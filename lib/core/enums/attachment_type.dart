import 'package:hive/hive.dart';

part 'attachment_type.g.dart';

@HiveType(typeId: 2)
enum AttachmentType {
  @HiveField(0)
  image,
  @HiveField(1)
  audio,
  @HiveField(2)
  video,
  @HiveField(3)
  unknown
}
