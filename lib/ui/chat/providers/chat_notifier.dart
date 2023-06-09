import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:humble/ui/chat/models/chat.dart';
import 'package:humble/ui/chat/models/chat_state.dart';
import 'package:humble/ui/chat/providers/chat_repository_provider.dart';
import 'package:humble/ui/chat/providers/messages_notifier_provider.dart';
import 'package:humble/ui/profile/providers/my_profile_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/message.dart';

part 'chat_notifier.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  ChatState build(String receiverId) {
    return ChatState(receiverId: receiverId);
  }

  void textChanged(String? v) {
    state = state.copyWith(text: v);
  }

  void fileChanged(File? v) {
    state = state.copyWith(file: v);
  }

  void send() async {
    state = state.copyWith(loading: true);
    try {
      final profile = await ref.read(profileProvider.future);
      final chatId = Chat.getConversationIDByIds(profile.id, receiverId);
      final message = Message(
        id: '',
        senderId: profile.id,
        chatId: chatId,
        receiverId: receiverId,
        text: state.text,
        createdAt: DateTime.now(),
      );
      final messagesModel =  ref.read(messagesNotifierProvider(chatId));
      await ref.read(chatRepositoryProvider).sendMessage(
            message,
            isNew: messagesModel.messages.isEmpty,
            file: state.file,
          );
    } catch (e) {
      debugPrint('$e');
    }
    state = state.copyWith(loading: false, text: null, file: null);
  }
}
