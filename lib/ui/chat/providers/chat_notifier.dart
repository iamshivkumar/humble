import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:humble/ui/chat/models/chat.dart';
import 'package:humble/ui/chat/models/chat_state.dart';
import 'package:humble/ui/chat/providers/message_sender_provider.dart';
import 'package:humble/ui/chat/providers/messages_box_provider.dart';
import 'package:humble/ui/profile/providers/profile_provider.dart';
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
    // state = state.copyWith(loading: false, text: null, file: null);
  }
}
