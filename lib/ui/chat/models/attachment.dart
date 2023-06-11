// ignore_for_file: invalid_annotation_target

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:humble/core/enums/attachment_type.dart';
part 'attachment.g.dart';

@HiveType(typeId: 1)
class Attachment {
  @HiveField(0)
  final String value;
  @HiveField(1)
  final AttachmentType type;
  @HiveField(2)
  final String ending;
  @HiveField(3)
  final String? name;
  Attachment({
    required this.value,
    required this.type,
    required this.ending,
    this.name,
  });

  Attachment copyWith({
    String? value,
    AttachmentType? type,
    String? ending,
    String? name,
  }) {
    return Attachment(
      value: value ?? this.value,
      type: type ?? this.type,
      ending: ending ?? this.ending,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'type': type.name,
      'ending': ending,
      'name': name,
    };
  }

  factory Attachment.fromMap(Map<String, dynamic> map) {
    return Attachment(
      value: map['value'] ?? '',
      type: AttachmentType.values.firstWhere(
        (element) => element.name == map['type'],
      ),
      ending: map['ending'] ?? '',
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment.fromJson(String source) =>
      Attachment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attachment(value: $value, type: $type, ending: $ending, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attachment &&
        other.value == value &&
        other.type == type &&
        other.ending == ending &&
        other.name == name;
  }

  @override
  int get hashCode {
    return value.hashCode ^ type.hashCode ^ ending.hashCode ^ name.hashCode;
  }

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
