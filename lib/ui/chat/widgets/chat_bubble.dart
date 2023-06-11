import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/enums/attachment_type.dart';
import 'package:humble/core/providers/file_provider.dart';
import 'package:humble/core/providers/thumbnail_provider.dart';
import 'package:humble/core/utils/ids.dart';
import 'package:humble/ui/auth/providers/user_provider.dart';
import 'package:humble/ui/chat/models/attachment.dart';
import 'package:humble/ui/chat/providers/chat_repository_provider.dart';
import 'package:humble/ui/chat/providers/message_sender_provider.dart';
import 'package:humble/ui/chat/providers/messages_box_provider.dart';
import 'package:humble/ui/chat/video_player_page.dart';
import 'package:humble/ui/chat/widgets/audio_player_title.dart';
import 'package:humble/ui/components/async_widget.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../models/message.dart';

class MessageBubble extends HookConsumerWidget {
  const MessageBubble({Key? key, required this.message, required this.isMy})
      : super(key: key);

  final Message message;
  final bool isMy;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final user = ref.read(userProvider).value!;
    final seen = useRef(message.seen);
    useEffect(() {
      if (!seen.value && message.receiverId == user.$id) {
        ref.read(chatRepositoryProvider).seenMessage(message.id);
      }
      if (message.id.isEmpty && message.key != null) {
        ref.read(messageSenderProvider(message.key));
      }
      if (message.id.isNotEmpty && message.hiveKey != null) {
        ref.read(messagesBoxProvider).value!.delete(message.hiveKey);
      }
      return () {};
    }, []);
    Widget fileView(File file) {
      final type = Attachment.getTypeFromPath(file.path);
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0,
          maxHeight: type == AttachmentType.audio
              ? double.infinity
              : (context.media.size.width * 3 / 4),
          minWidth: context.media.size.width / 2,
          maxWidth: context.media.size.width * 2 / 3,
        ),
        child: switch (type) {
          AttachmentType.video => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(path: file.path),
                        fullscreenDialog: true));
              },
              child: AsyncWidget(
                value: ref.watch(thumbnailProvider(file.path)),
                data: (data) => data != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(data),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          AttachmentType.audio => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.scheme.surface,
              ),
              child: AudioPlayerTile(file: file.path),
            ),
          AttachmentType.image => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                file,
                fit: BoxFit.cover,
              ),
            ),
          _ => const SizedBox()
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isMy ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMy) const Spacer(),
          Flexible(
            flex: 3,
            child: Container(
              width: [AttachmentType.image, AttachmentType.video].contains(
                message.attachment?.type ??
                    Attachment.getTypeFromPath(message.file ?? '.'),
              )
                  ? (context.media.size.width / 2 + 16)
                  : null,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(isMy ? 0 : 16),
                  bottomLeft: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
                  topLeft: Radius.circular(isMy ? 16 : 0),
                ),
                color:
                    isMy ? scheme.tertiaryContainer : scheme.primaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment:
                      (message.attachment != null || message.file != null)
                          ? CrossAxisAlignment.stretch
                          : isMy
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                  children: [
                    if (message.attachment != null)
                      Consumer(
                        builder: (context, ref, child) {
                          final fileAsync = ref.watch(fileProvider(
                              Buckets.attachments,
                              message.attachment!.value,
                              message.attachment!.ending));
                          return fileAsync.when(
                            data: (file) => fileView(file),
                            error: (error, stackTrace) => Center(
                              child: Text('$error'),
                            ),
                            loading: () => const LinearProgressIndicator(),
                          );
                        },
                      ),
                    if (message.attachment == null && message.file != null)
                      fileView(
                        File(message.file!),
                      ),
                    if (message.attachment != null || message.file != null)
                      const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          if (message.text != null)
                            Text(
                              message.text!,
                              style: style.bodyLarge!.copyWith(
                                  color: isMy
                                      ? scheme.onTertiaryContainer
                                      : scheme.onPrimaryContainer),
                            ),
                          Text(
                            message.createdAt.time,
                            style: style.labelSmall!.copyWith(
                              color: (isMy
                                      ? scheme.onTertiaryContainer
                                      : scheme.onPrimaryContainer)
                                  .withOpacity(0.75),
                            ),
                          ),
                          if (isMy)
                            Icon(
                              message.seen
                                  ? Icons.done_all_rounded
                                  : message.id.isNotEmpty
                                      ? Icons.done_rounded
                                      : Icons.access_time_rounded,
                              size: 16,
                              color: context.scheme.tertiary,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!isMy) const Spacer()
        ],
      ),
    );
  }
}
