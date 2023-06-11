import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:humble/core/utils/extensions.dart';
import 'package:humble/ui/chat/models/attachment.dart';
import 'package:humble/ui/chat/models/message.dart';
import 'package:humble/ui/chat/providers/attachment_uploader_provider.dart';
import 'package:humble/ui/chat/providers/chat_repository_provider.dart';
import 'package:humble/ui/chat/providers/messages_box_provider.dart';
import 'package:humble/ui/chat/providers/messages_notifier_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

import 'directory_provider.dart';

part 'message_sender_provider.g.dart';

@riverpod
Future<void> messageSender(MessageSenderRef ref, dynamic key) async {
  ref.keepAlive();
  final completer = Completer<void>();
  final box = await ref.read(messagesBoxProvider.future);
  final message = box.get(key)!;

  Future<void> sendMessage(Message updated) async {
    final messages =
        ref.read(messagesNotifierProvider(message.chatId)).messages;
    await ref.read(chatRepositoryProvider).sendMessage(
          updated,
          file: message.file != null ? File(message.file!) : null,
          isNew: messages.isEmpty,
          unseen: messages
              .where((element) =>
                  element.receiverId == message.receiverId && !element.seen)
              .length,
        );
    completer.complete();
  }

  if (message.file != null && message.attachment == null) {
    ref.read(attachmentUploaderProvider(message.key));
    ref.listen(attachmentUploaderProvider(message.key!),
        (previous, next) async {
      if (previous?.value?.progress != next.value?.progress &&
          next.value!.progress == 100) {
        final UploadProgress progress = next.value!;
        final updated = message.copyWith(
          attachment: Attachment(
            value: progress.$id,
            type: Attachment.getTypeFromPath(message.file!),
            ending: message.file!.ending,
            name: message.file?.split('/').last,
          ),
        );
        box.put(key, updated);
        sendMessage(updated);
      }
    });
  } else {
    sendMessage(message);
  }
  return completer.future;
}
