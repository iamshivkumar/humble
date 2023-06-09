import 'package:freezed_annotation/freezed_annotation.dart';
import 'message.dart';

part 'messages_state.freezed.dart';


@freezed
class MessagesState with _$MessagesState {
  factory MessagesState({
    @Default([]) List<Message> messages,
    @Default(true) bool loading,
    @Default(false) bool moreLoading,
  }) = _MessagesState;
}
