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

import '../../core/providers/messaging_provider.dart';
import '../auth/providers/user_provider.dart';

class Dashboard extends HookConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seen = useRef(<String>{});
    void handleRoute(RemoteMessage message) {
      try {
        switch (message.data['type']) {
          case 'chat':
            final receiverId = message.data['receiverId'];
            if (receiverId != null) {
              context.push(Routes.chat, extra: receiverId);
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
      if (current == AppLifecycleState.resumed) {
        getInitialMessage();
      }
    });

    useEffect(() {
      final messaging = ref.read(messagingProvider);
      final tokenSubscription = messaging.onTokenRefresh.listen(
        (event) {
          final user = ref.read(userProvider).value!;
          ref
              .read(profileRepositoryProvider)
              .updateFcmToken(uid: user.$id, token: event);
        },
      );
      getInitialMessage();

      final messageSubscription =
          FirebaseMessaging.onMessage.listen((event) async {
        if (event.messageId != null) {
          seen.value.add(event.messageId!);
        }
        // final value = await showDialog(
        //   context: context,
        //   builder: (context) => MessageDialog(
        //     notification: notification,
        //   ),
        // );

        // if (value == true) {
        //   handleRoute(event);
        // }
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
