import 'dart:io' as io;

import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:humble/core/models/debouncer.dart';
import 'package:humble/ui/auth/providers/user_provider.dart';
import 'package:humble/ui/chat/models/chat.dart';
import 'package:humble/ui/chat/models/chat_state.dart';
import 'package:humble/ui/chat/providers/chat_repository_provider.dart';
import 'package:humble/ui/chat/providers/message_sender_provider.dart';
import 'package:humble/ui/chat/providers/messages_box_provider.dart';
import 'package:humble/ui/profile/providers/profile_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/message.dart';
import 'chats_provider.dart';
part 'chat_notifier.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  ChatState build(String receiverId) {
    debouncer = Debouncer(const Duration(milliseconds: 500), (value) {
      final chat = ref
          .read(chatsProvider)
          .asData
          ?.value
          .cast<Chat?>()
          .firstWhere((element) => element?.id == chatId, orElse: () => null);
      if (chat == null) return;
      var typing = chat.typing;
      final current = typing[_user.$id];
      final updated = value.isNotEmpty;
      if(current != updated){
        typing[_user.$id] = value.isNotEmpty;
      _repository.updateTyping(chatId: chatId, typing: typing);
      }
    });
    return ChatState(receiverId: receiverId);
  }

  ChatRepository get _repository => ref.read(chatRepositoryProvider);

  String get chatId => Chat.getConversationIDByIds(receiverId, _user.$id);

  User get _user => ref.read(userProvider).value!;

  late Debouncer debouncer;

  void textChanged(String? v) {
    state = state.copyWith(text: v);
  }

  void fileChanged(io.File? v) {
    state = state.copyWith(file: v);
  }

  void send() async {
    try {
      final profile = await ref.read(profileProvider.future);
      final message = Message(
        id: '',
        senderId: profile.id,
        chatId: chatId,
        receiverId: receiverId,
        text: state.text,
        createdAt: DateTime.now(),
        file: state.file?.path,
      );
      final box = ref.read(messagesBoxProvider).value!;
      final key = await box.add(message);
      ref.read(messageSenderProvider(key));
      state = state.copyWith(
        text: null,
        file: null,
      );
    } catch (e) {
      debugPrint('$e');
    }
  }
}
