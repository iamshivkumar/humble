import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default('') String newPassword,
    @Default(false) bool loading,
    @Default(true) bool obscurePassword,
    @Default(true) bool obscureNewPassword,
    @Default(true) bool obscureConfirmPassword,
  }) = _AuthState;
}
