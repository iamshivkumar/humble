import 'dart:async';

import 'package:humble/ui/auth/providers/user_provider.dart';
import 'package:humble/ui/chat/providers/realtime_events_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/ids.dart';
import '../models/chat.dart';
import '../models/realtime_event.dart';
import 'chat_repository_provider.dart';

part 'chats_provider.g.dart';

@riverpod
Stream<List<Chat>> chats(ChatsRef ref) {
  ref.keepAlive();
  List<Chat> list = [];
  final controller = StreamController<List<Chat>>();
  ref.watch(userProvider.future).then((value) {
    ref.read(chatRepositoryProvider).listChats(value.$id).then((value) {
      list = value;
      controller.add(list);
    });
    ref.listen(realtimeEventsProvider.select((value) => value.asData?.value),
        (_, next) {
      if (next?.document.$collectionId == Collections.chats) {
        final chat = Chat.fromDocument(next!.document);
        if (chat.users.contains(value.$id)) {
          switch (next.type) {
            case RealtimeChange.create:
              list = [chat, ...list];
              break;
            case RealtimeChange.update:
              list = list.map((e) => e.id == chat.id ? chat : e).toList();
              break;
            case RealtimeChange.delete:
              list.removeWhere((element) => element.id == chat.id);
            default:
          }
          controller.add(list);
        }
      }
    });
  }).catchError((e) {
    controller.addError('User not logined');
  });
  return controller.stream;
}


// final chatsProvider = StreamProvider.family<List<Chat>, String>(
//   (ref, id) {
//     ref.read(chatRepositoryProvider).listChats()
//   },
// );
