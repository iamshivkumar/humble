import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/chat/providers/attachment_uploader_provider.dart';
import 'package:humble/ui/utils/extensions.dart';

class UploadProgressIndicator extends ConsumerWidget {
  const UploadProgressIndicator({super.key, required this.hiveKey});

  final int hiveKey;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(attachmentUploaderProvider(hiveKey)).asData?.value.progress;
    print(progress);
    return Positioned(
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            value: progress == null? null: progress/100,
            color: context.scheme.primary,
          ),
        ),
      ),
    );
  }
}
