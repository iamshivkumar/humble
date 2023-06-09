// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:humble/core/enums/attachment_type.dart';

class Attachment {
  final String value;
  final AttachmentType type;
  final String ending;

  Attachment({
    required this.value,
    required this.type,
    required this.ending,
  });

  Attachment copyWith({
    String? value,
    AttachmentType? type,
    String? ending,
  }) {
    return Attachment(
      value: value ?? this.value,
      type: type ?? this.type,
      ending: ending ?? this.ending,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'type': type.name,
      'ending': ending,
    };
  }

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      value: map['value'] ?? '',
      type: AttachmentType.values.firstWhere(
        (element) => element.name == map['type'],
      ),
      ending: map['ending'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment.fromJson(String source) =>
      Attachment.fromMap(json.decode(source));

  @override
  String toString() =>
      'Attachment(value: $value, type: $type, ending: $ending)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attachment &&
        other.value == value &&
        other.type == type &&
        other.ending == ending;
  }

  @override
  int get hashCode => value.hashCode ^ type.hashCode ^ ending.hashCode;

  static AttachmentType getTypeFromPath(String path) {
    final ending = path.split('.').last;
    return switch (ending) {
      'jpg' || 'png' || 'jpeg' => AttachmentType.image,
      'mp4' => AttachmentType.video,
      'mp3' => AttachmentType.audio,
      _ => AttachmentType.unknown,
    };
  }
}
