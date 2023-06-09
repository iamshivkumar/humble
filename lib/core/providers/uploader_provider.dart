import 'dart:async';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:humble/core/providers/storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'uploader_provider.g.dart';

@riverpod
Stream<UploadProgress> uploader(UploaderRef ref,
    {required File file, String? id, required String bucketId}) {
  final controller = StreamController<UploadProgress>();
  ref.keepAlive();
  ref.read(storageProvider).createFile(
        bucketId: bucketId,
        fileId: id ?? ID.unique(),
        file: InputFile.fromPath(
          filename: id,
          path: file.path,
        ),
        onProgress: (v) {
          controller.add(v);
        },
      );
  return controller.stream;
}
