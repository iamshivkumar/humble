import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:humble/core/utils/extensions.dart';
import 'package:humble/ui/chat/models/attachment.dart';
import 'package:humble/ui/chat/providers/attachment_uploader_provider.dart';
import 'package:humble/ui/chat/providers/chat_repository_provider.dart';
import 'package:humble/ui/chat/providers/messages_box_provider.dart';
import 'package:humble/ui/chat/providers/messages_notifier_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part 'message_sender_provider.g.dart';

@riverpod
Future<void> messageSender(MessageSenderRef ref, dynamic key) async {
  ref.keepAlive();
  final completer = Completer<void>();
  final box = await ref.read(messagesBoxProvider.future);
  final message = box.get(key)!;
  // ref.listen(uploaderProvider., (previous, next) { })
  if (message.file != null && message.attachment == null) {
    ref.read(attachmentUploaderProvider(message.file!));
    ref.listen(attachmentUploaderProvider(message.file!), (previous, next) {
      if (previous?.value?.progress != next.value?.progress &&
          next.value!.progress == 100) {
        final UploadProgress progress = next.value!;
        final updated = message.copyWith(
          attachment: Attachment(
            value: progress.$id,
            type: Attachment.getTypeFromPath(message.file!),
            ending: message.file!.ending,
          ),
        );
        box.put(key, updated);
        ref.read(chatRepositoryProvider).sendMessage(
              updated,
              file: message.file != null ? File(message.file!) : null,
              isNew: ref
                  .read(messagesNotifierProvider(message.chatId))
                  .messages
                  .isEmpty,
            );
      }
    });
  } else {
    await ref.read(chatRepositoryProvider).sendMessage(
          message,
          file: message.file != null ? File(message.file!) : null,
          isNew: ref
              .read(messagesNotifierProvider(message.chatId))
              .messages
              .isEmpty,
        );
    completer.complete();
  }
  return completer.future;
}