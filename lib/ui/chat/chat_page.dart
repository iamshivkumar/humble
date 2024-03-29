import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/chat/providers/chat_notifier.dart';
import 'package:humble/ui/chat/providers/chat_repository_provider.dart';
import 'package:humble/ui/chat/providers/chats_provider.dart';
import 'package:humble/ui/chat/providers/messages_box_provider.dart';
import 'package:humble/ui/chat/providers/messages_notifier_provider.dart';
import 'package:humble/ui/chat/widgets/chat_appbar.dart';
import 'package:humble/ui/chat/widgets/chat_input_view.dart';
import 'package:humble/ui/utils/extensions.dart';
import '../auth/providers/user_provider.dart';
import 'models/chat.dart';
import 'models/message.dart';
import 'widgets/chat_bubble.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({Key? key, required this.receiverId}) : super(key: key);
  final String receiverId;

  static const route = "/chat";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider).value!;
    final notifer = ref.read(chatNotifierProvider(receiverId).notifier);
    ref.watch(chatNotifierProvider(receiverId));

    final messagesProvider = messagesNotifierProvider(notifer.chatId);
    final messagesState = ref.watch(messagesProvider);
    useEffect(() {
      ref.read(chatsProvider.future).then((value) {
        final chat = value.cast<Chat?>().firstWhere(
            (element) => element?.id == notifer.chatId,
            orElse: () => null);
        if (chat != null) {
          if (chat.message?.receiverId == user.$id && chat.unseen != 0) {
            ref.read(chatRepositoryProvider).makeUnseenZero(chat.id);
          }
        }
      });
      return () {
        notifer.debouncer.value = '';
      };
    }, []);

    final messagesNotifier = ref.read(messagesProvider.notifier);

    final hiveMessages = ref.read(messagesBoxProvider).value?.values.where(
          (message) {
            print(message.chatId);
            print(message.chatId == notifer.chatId);
            return message.chatId == notifer.chatId &&
                messagesState.messages
                    .where((element) => element.hiveKey == message.key)
                    .isEmpty;
          },
        ) ??
        [];
    final messages = [
      ...messagesState.messages,
      ...hiveMessages,
    ];

    Map<DateTime, List<Message>> map = {};
    for (var message in messages) {
      if (map[message.createdAt.date] == null) {
        map[message.createdAt.date] = [];
      }
      map[message.createdAt.date]!.add(message);
    }
    final entries = map.entries.toList();
    entries.sort((a, b) => b.key.compareTo(a.key));

    return Scaffold(
      appBar: ChatAppBar(
        receiverId: receiverId,
        chatId: notifer.chatId,
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesState.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      //TODO: check this & update
                      if (!messagesNotifier.busy &&
                          notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent &&
                          notification.metrics.maxScrollExtent > 0) {
                        messagesNotifier.loadMore();
                      }
                      return true;
                    },
                    child: SingleChildScrollView(
                      reverse: true,
                      padding: const EdgeInsets.all(8),
                      child: Column(children: [
                        /// Check this
                        if (messagesState.moreLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ...entries.reversed.map((e) {
                          e.value.sort(
                              (a, b) => a.createdAt.compareTo(b.createdAt));
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: context.scheme.surfaceVariant,
                                  shape: const StadiumBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      e.key.monthDay,
                                      style: TextStyle(
                                          color:
                                              context.scheme.onSurfaceVariant),
                                    ),
                                  ),
                                ),
                              ),
                              ...e.value
                                  .map(
                                    (e) => MessageBubble(
                                      message: e,
                                      isMy: e.senderId == user.$id,
                                    ),
                                  )
                                  .toList(),
                            ],
                          );
                        }),
                      ]),
                    ),
                  ),
          ),
          ChatInputView(receiverId: receiverId),
        ],
      ),
    );
  }
}
