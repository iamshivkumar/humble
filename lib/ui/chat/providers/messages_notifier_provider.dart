import 'package:humble/core/utils/buckets.dart';
import 'package:humble/ui/chat/models/message.dart';
import 'package:humble/ui/chat/models/messages_state.dart';
import 'package:humble/ui/chat/models/realtime_event.dart';
import 'package:humble/ui/chat/providers/chat_repository_provider.dart';
import 'package:humble/ui/chat/providers/realtime_events_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_notifier_provider.g.dart';

@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  @override
  MessagesState build(String chatId) {
    ref.keepAlive();
    _fetch();
    _syncChanges();
    return MessagesState();
  }

  bool busy = false;

  ChatRepository get _repository => ref.read(chatRepositoryProvider);

  void _fetch({
    int offset = 0,
  }) async {
    busy = true;
    final limit = offset == 0 ? 10 : 5;
    final newMessages = await _repository.paginateMessages(
      chatId,
      offset: offset,
      limit: limit,
    );
    final messages = [if (offset != 0) ...state.messages, ...newMessages];
    state = state.copyWith(
      messages: messages,
      loading: false,
      moreLoading: newMessages.length == limit ? true : false,
    );
    busy = false;
  }

  void loadMore() async {
    _fetch(
      offset: state.messages.length,
    );
  }

  void _syncChanges() {
    ref.listen(realtimeEventsProvider.select((value) => value.asData?.value),
        (_, next) {
      if (next?.document.$collectionId == Collections.messages) {
        final message = Message.fromMap(next!.document.data);
        if (message.chatId == chatId) {
          switch (next.type) {
            case RealtimeChange.create:
              state = state.copyWith(messages: [
                message,
                ...state.messages,
              ]);
              break;
            case RealtimeChange.update:
              state = state.copyWith(
                messages: state.messages
                    .map((e) => e.id == message.id ? message : e)
                    .toList(),
              );
              break;
            case RealtimeChange.delete:
              state = state.copyWith(
                messages: state.messages
                    .where((element) => element.id != message.id)
                    .toList(),
              );
            default:
          }
        }
      }
    });
  }
}
