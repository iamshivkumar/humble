import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/chat/chats_page.dart';
import 'package:humble/ui/home/home_page.dart';
import 'package:humble/ui/profile/account_page.dart';
import 'package:humble/ui/profile/providers/profile_repository_provider.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../../core/providers/messaging_provider.dart';
import '../auth/providers/user_provider.dart';

class Dashboard extends HookConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileRepo = ref.read(profileRepositoryProvider);
    final user = ref.read(userProvider).value!;

    final seen = useRef(<String>{});
    void handleRoute(RemoteMessage message) {
      try {
        switch (message.data['type']) {
          case 'chat':
            final senderId = message.data['senderId'];
            if (senderId != null) {
              context.push(Routes.chat, extra: senderId);
            }
            break;
          default:
        }
      } catch (e) {
        debugPrint("$e");
      }
    }

    void getInitialMessage() async {
      final messaging = ref.read(messagingProvider);
      final message = await messaging.getInitialMessage();
      if (message != null && !seen.value.contains(message.messageId)) {
        seen.value.add(message.messageId!);
        handleRoute(message);
      }
    }

    useOnAppLifecycleStateChange((previous, current) {
      if (previous == AppLifecycleState.paused &&
          current == AppLifecycleState.resumed) {
        getInitialMessage();
      }
      if ([
        AppLifecycleState.detached,
        AppLifecycleState.inactive,
        AppLifecycleState.paused
      ].contains(current)) {
        profileRepo.updateOnlineStatus(uid: user.$id, value: false);
      } else if (current == AppLifecycleState.resumed) {
        profileRepo.updateOnlineStatus(uid: user.$id, value: true);
      }
    });

    useEffect(() {
      final messaging = ref.read(messagingProvider);
      final tokenSubscription = messaging.onTokenRefresh.listen(
        (event) {
          profileRepo.updateFcmToken(uid: user.$id, token: event);
        },
      );

      getInitialMessage();
      profileRepo.updateOnlineStatus(uid: user.$id, value: true);
      final messageSubscription =
          FirebaseMessaging.onMessage.listen((event) async {
        if (event.messageId != null) {
          seen.value.add(event.messageId!);
        }
        if (GoRouter.of(context).location == Routes.root) {
          final messenger = ScaffoldMessenger.of(context);
          messenger.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: context.scheme.onPrimaryContainer,
              content: Text(
                '${event.notification!.title ?? ''}: ${event.notification!.body}',
                style: TextStyle(
                  color: context.scheme.primaryContainer,
                ),
              ),
              action: SnackBarAction(
                textColor: context.scheme.tertiaryContainer,
                label: "Go to chat",
                onPressed: () {
                  handleRoute(event);
                },
              ),
            ),
          );
        }
      });
      return () {
        tokenSubscription.cancel();
        messageSubscription.cancel();
      };
    }, []);

    final index = useState(0);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: index.value,
        onDestinationSelected: (value) {
          index.value = value;
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chat',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
      ),
      body: [
        const HomePage(),
        const ChatsPage(),
        const AccountPage(),
      ][index.value],
    );
  }
}
