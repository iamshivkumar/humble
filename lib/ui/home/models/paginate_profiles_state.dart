import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:humble/ui/profile/models/profile.dart';

part 'paginate_profiles_state.freezed.dart';

@freezed
class PaginateProfileState with _$PaginateProfileState {
  factory PaginateProfileState({
    @Default([]) List<Profile> profiles,
    @Default(true) bool loading,
    @Default(false) bool moreLoading,
    @Default([]) List<String> interests,
  }) = _PaginateProfileState;
}
