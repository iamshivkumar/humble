import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/enums/attachment_type.dart';
import 'package:humble/core/providers/file_provider.dart';
import 'package:humble/core/providers/image_provider.dart';
import 'package:humble/core/providers/thumbnail_provider.dart';
import 'package:humble/core/utils/buckets.dart';
import 'package:humble/ui/chat/video_player_page.dart';
import 'package:humble/ui/chat/widgets/audio_player_title.dart';
import 'package:humble/ui/components/async_widget.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.message, required this.isMy})
      : super(key: key);

  final Message message;
  final bool isMy;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
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
              width: message.attachment != null &&
                      message.attachment!.type != AttachmentType.audio
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
                    isMy ? scheme.primaryContainer : scheme.secondaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment:
                      isMy ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (message.attachment != null)
                      switch (message.attachment!.type) {
                        AttachmentType.image => Consumer(
                            builder: (context, ref, child) {
                              final imageAsync = ref.watch(memoryImageProvider(
                                  Buckets.attachments,
                                  message.attachment!.value));
                              return imageAsync.isLoading
                                  ? CircularProgressIndicator()
                                  : imageAsync.asData?.value != null
                                      ? ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight:
                                                context.media.size.width *
                                                    3 /
                                                    4,
                                            minWidth:
                                                context.media.size.width / 2,
                                            maxWidth: context.media.size.width *
                                                2 /
                                                3,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image(
                                              image: imageAsync.value!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                            },
                          ),
                        _ => Consumer(
                            builder: (context, ref, child) {
                              final file = ref
                                  .watch(fileProvider(
                                      Buckets.attachments,
                                      message.attachment!.value,
                                      message.attachment!.ending))
                                  .asData
                                  ?.value;
                              return file != null
                                  ? ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minHeight: 0,
                                        maxHeight: message.attachment!.type ==
                                                AttachmentType.audio
                                            ? double.infinity
                                            : (context.media.size.width *
                                                3 /
                                                4),
                                        minWidth: context.media.size.width / 2,
                                        maxWidth:
                                            context.media.size.width * 2 / 3,
                                      ),
                                      child: switch (message.attachment!.type) {
                                        AttachmentType.video => GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VideoPlayerPage(
                                                              path: file.path),
                                                      fullscreenDialog: true));
                                            },
                                            child: AsyncWidget(
                                              value: ref.watch(
                                                  thumbnailProvider(file.path)),
                                              data: (data) => data != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.file(
                                                        File(data),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ),
                                          ),
                                        AttachmentType.audio =>
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: context.scheme.surface,
                                            ),
                                            child: AudioPlayerTile(file: file.path),
                                          ),
                                        _ => const SizedBox()
                                      })
                                  : const SizedBox();
                            },
                          )
                      },
                    if (message.attachment != null) const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        if (message.text != null)
                          Text(
                            message.text!,
                            style: style.bodyLarge!.copyWith(
                                color: isMy
                                    ? scheme.onPrimaryContainer
                                    : scheme.onSecondaryContainer),
                          ),
                        Text(
                          message.createdAt.time,
                          style: style.labelSmall!.copyWith(
                            color: (isMy
                                    ? scheme.onPrimaryContainer
                                    : scheme.onSecondaryContainer)
                                .withOpacity(0.75),
                          ),
                        ),
                      ],
                    )
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
