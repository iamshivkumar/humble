// ignore_for_file: invalid_annotation_target

import 'dart:convert';
import 'package:hive/hive.dart';

import 'attachment.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String chatId;
  @HiveField(2)
  final String senderId;
  @HiveField(3)
  final String receiverId;
  @HiveField(4)
  final Attachment? attachment;
  @HiveField(5)
  final String? text;
  @HiveField(6)
  final bool seen;
  @HiveField(7)
  final DateTime createdAt;
  @HiveField(8)
  final int? hiveKey;
  @HiveField(9)
  final String? file;
  @HiveField(10)
  final String? error;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    this.attachment,
    this.text,
    required this.createdAt,
    this.seen = false,
    this.hiveKey,
    this.error,
    this.file,
  });

  String? subtitleText(String uid) {
    if (text != null) {
      return text!;
    } else {
      if (attachment != null) {
        return '${uid == senderId ? "You sent" : "Sent"} ${attachment!.type.name}';
      }
    }
    return null;
  }

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? receiverId,
    Attachment? attachment,
    String? text,
    DateTime? createdAt,
    bool? seen,
    String? error,
    int? hiveKey,
    String? file,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      attachment: attachment ?? this.attachment,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      seen: seen ?? this.seen,
      error: error ?? this.error,
      hiveKey: hiveKey ?? this.hiveKey ?? key,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'attachment': attachment?.toJson(),
      'text': text,
      r'$createdAt': createdAt.toIso8601String(),
      'seen': seen,
      'hiveKey': hiveKey ?? key,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map[r'$id'] ?? '',
      chatId: map['chatId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      attachment: map['attachment'] != null
          ? Attachment.fromJson(map['attachment'])
          : null,
      text: map['text'],
      createdAt: DateTime.parse(map[r'$createdAt']).toLocal(),
      seen: map['seen'] ?? false,
      hiveKey: map['hiveKey'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, chatId: $chatId, senderId: $senderId, receiverId: $receiverId, attachment: $attachment, text: $text, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.chatId == chatId &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.attachment == attachment &&
        other.text == text &&
        other.createdAt == createdAt &&
        other.seen == seen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        chatId.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        attachment.hashCode ^
        text.hashCode ^
        seen.hashCode ^
        createdAt.hashCode;
  }
}
