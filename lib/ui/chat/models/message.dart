// ignore_for_file: invalid_annotation_target

import 'dart:convert';
import 'attachment.dart';

class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String receiverId;
  final Attachment? attachment;
  final String? text;
  final bool seen;
  final DateTime createdAt;
  
  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    this.attachment,
    this.text,
    required this.createdAt,
    this.seen = false,
  });

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? receiverId,
    Attachment? attachment,
    String? text,
    DateTime? createdAt,
    bool? seen,
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
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map[r'$id'] ?? '',
      chatId: map['chatId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      attachment: map['attachment'] != null ? Attachment.fromJson(map['attachment']) : null,
      text: map['text'],
      createdAt: DateTime.parse(map[r'$createdAt']),
      seen: map['seen']?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));

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
