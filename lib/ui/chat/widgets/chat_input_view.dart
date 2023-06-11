import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/utils/extensions.dart';
import 'package:humble/ui/chat/widgets/audio_player_title.dart';
import 'package:humble/ui/utils/extensions.dart';
import 'package:video_player/video_player.dart';

import '../../../core/enums/attachment_type.dart';
import '../models/attachment.dart';
import '../providers/chat_notifier.dart';

class ChatInputView extends HookConsumerWidget {
  const ChatInputView({super.key, required this.receiverId});
  final String receiverId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(chatNotifierProvider(receiverId).notifier);
    final model = ref.watch(chatNotifierProvider(receiverId));
    final controller = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (model.file != null)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: context.scheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    switch (Attachment.getTypeFromPath(model.file!.path)) {
                      AttachmentType.image => AspectRatio(
                          aspectRatio: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.file(model.file!),
                          ),
                        ),
                      AttachmentType.video => AbsorbPointer(
                          absorbing: true,
                          child: HookConsumer(
                            builder: (context, ref, child) {
                              final initialized = useState<bool>(false);
                              final controller =
                                  useRef(VideoPlayerController.file(model.file!)
                                    ..initialize().then((value) {
                                      initialized.value = true;
                                    }));

                              return initialized.value
                                  ? Center(
                                      child: SizedBox(
                                        width: context.media.size.width / 2,
                                        height: (context.media.size.width / 2) /
                                            controller.value.value.aspectRatio,
                                        child: VideoPlayer(
                                          controller.value,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      color: context.scheme.outlineVariant,
                                    );
                            },
                          ),
                        ),
                      AttachmentType.audio => Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          child: AudioPlayerTile(file: model.file!.path),
                        ),
                      _ => Text(model.file!.path.split('/').last),
                    },
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          notifier.fileChanged(null);
                        },
                        icon: const Icon(Icons.clear_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowMultiple: false);

                    if (result != null && result.files.isNotEmpty) {
                      notifier.fileChanged(File(result.paths.first!));
                    }
                  },
                  icon: const Icon(Icons.attachment_rounded),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (v) {
                      notifier.textChanged(v.trim().crim);
                      notifier.debouncer.value = v.trim();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      hintText: "Type your message..",
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 48,
                  width: 48,
                  child: RawMaterialButton(
                    fillColor: model.text != null
                        ? context.scheme.primary
                        : context.scheme.outlineVariant,
                    shape: const CircleBorder(),
                    onPressed: model.text?.crim != null || model.file != null
                        ? () {
                            notifier.send();
                            controller.clear();
                            notifier.debouncer.value = '';
                          }
                        : null,
                    child: Icon(
                      Icons.send,
                      color: context.scheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
