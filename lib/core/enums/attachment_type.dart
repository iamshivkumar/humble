import 'package:freezed_annotation/freezed_annotation.dart';

enum AttachmentType {
  @JsonValue('image')
  image,
  @JsonValue('audio')
  audio,
  @JsonValue('video')
  video,
  @JsonValue('unknown')
  unknown
}
