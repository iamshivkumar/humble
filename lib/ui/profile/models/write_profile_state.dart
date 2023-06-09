import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:humble/ui/profile/models/profile.dart';

part 'write_profile_state.freezed.dart';

@freezed
class WriteProfileState with _$WriteProfileState {
  factory WriteProfileState(
      {File? file,
      @Default(Profile()) Profile profile,
      @Default(false) loading}) = _WriteProfileState;
}
