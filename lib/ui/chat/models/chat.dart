// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import 'package:humble/ui/chat/models/message.dart';

class Chat {
  final String id;
  final List<String> users;
  final Message? message;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Chat({
    required this.id,
    required this.users,
    this.message,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    this.updatedAt,
  });

  static String getConversationIDByIds(String id1, String id2) {
    final input = id1.hashCode <= id2.hashCode ? '$id1$id2' : '$id2$id1';
    return getChatSessionId(input);
  }

  static String getChatSessionId(String input) {
    Digest hash = md5.convert(utf8.encode(input));
    return hash.toString();
  }

  Chat copyWith({
    String? id,
    List<String>? users,
    Message? message,
    String? createdBy,
    String? updatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chat(
      id: id ?? this.id,
      users: users ?? this.users,
      message: message ?? this.message,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'users': users,
      'message': message?.toJson(),
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }

  factory Chat.fromDocument(Document doc) {
    final Map<String, dynamic> map = doc.data;
    return Chat(
      id: doc.$id,
      users: List<String>.from(map['users']),
      message: map['message'] != null ? Message.fromJson(map['message']) : null,
      createdBy: map['createdBy'] ?? '',
      updatedBy: map['updatedBy'],
      createdAt: DateTime.parse(map[r'$createdAt']),
      updatedAt: map[r'$updatedAt'] != null
          ? DateTime.tryParse(map[r'$updatedAt'])
          : null,
    );
  }

  @override
  String toString() {
    return 'Chat(id: $id, users: $users, message: $message, createdBy: $createdBy, updatedBy: $updatedBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.id == id &&
        listEquals(other.users, users) &&
        other.message == message &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        users.hashCode ^
        message.hashCode ^
        createdBy.hashCode ^
        updatedBy.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

extension ChatExtension on Chat {
  String get getConversationID {
    return Chat.getConversationIDByIds(users.first, users.last);
  }
}
