import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  factory ChatState({
    required String receiverId,
     String? text,
     File? file,
  }) = _ChatState;
}
