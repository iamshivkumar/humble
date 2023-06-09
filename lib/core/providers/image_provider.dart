import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'storage_provider.dart';

part 'image_provider.g.dart';





@riverpod
Future<MemoryImage> memoryImage (MemoryImageRef ref, String bucketId, String id) {
  ref.keepAlive();
  return ref
      .read(storageProvider)
      .getFilePreview(
        bucketId: bucketId,
        fileId: id,
      )
      .then(
        (value) => MemoryImage(value),
      );
}