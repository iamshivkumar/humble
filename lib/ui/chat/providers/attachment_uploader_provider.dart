import 'dart:async';
import 'package:appwrite/appwrite.dart';
import 'package:humble/core/providers/storage_provider.dart';
import 'package:humble/core/utils/ids.dart';
import 'package:humble/ui/chat/providers/messages_box_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final attachmentUploaderProvider =
    StreamProvider.family<UploadProgress, int>((ref, key) {
  final controller = StreamController<UploadProgress>();
  final message = ref.read(messagesBoxProvider).value!.get(key)!;
  final path = message.file!;
  ref
      .read(storageProvider)
      .createFile(
        bucketId: Buckets.attachments,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          filename:
              '${DateTime.now().millisecondsSinceEpoch}.${path.split('.').last}',
          path: path,
        ),
        onProgress: (v) {
          print(v);
          controller.add(v);
        },
      )
      .then((value) {
    controller.add(
      UploadProgress(
        $id: value.$id,
        progress: 100,
        sizeUploaded: 0,
        chunksTotal: 0,
        chunksUploaded: 0,
      ),
    );
  });
  return controller.stream;
});
