// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttachmentTypeAdapter extends TypeAdapter<AttachmentType> {
  @override
  final int typeId = 2;

  @override
  AttachmentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AttachmentType.image;
      case 1:
        return AttachmentType.audio;
      case 2:
        return AttachmentType.video;
      case 3:
        return AttachmentType.unknown;
      default:
        return AttachmentType.image;
    }
  }

  @override
  void write(BinaryWriter writer, AttachmentType obj) {
    switch (obj) {
      case AttachmentType.image:
        writer.writeByte(0);
        break;
      case AttachmentType.audio:
        writer.writeByte(1);
        break;
      case AttachmentType.video:
        writer.writeByte(2);
        break;
      case AttachmentType.unknown:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
