import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:humble/core/providers/storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'file_provider.g.dart';

@riverpod
Future<File> file(
    FileRef ref, String bucketId, String id, String ending) async {
  ref.keepAlive();
  final dir = await getApplicationDocumentsDirectory();
  final f = File('${dir.path}/$id.$ending');
  if (await f.exists()) {
    return f;
  }
  final data = await ref.read(storageProvider).getFileDownload(
        bucketId: bucketId,
        fileId: id,
      );
  await f.writeAsBytes(data);
  return f;
}
