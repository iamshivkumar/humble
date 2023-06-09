// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginate_profiles_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PaginateProfileState {
  List<Profile> get profiles => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get moreLoading => throw _privateConstructorUsedError;
  List<String> get interests => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaginateProfileStateCopyWith<PaginateProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginateProfileStateCopyWith<$Res> {
  factory $PaginateProfileStateCopyWith(PaginateProfileState value,
          $Res Function(PaginateProfileState) then) =
      _$PaginateProfileStateCopyWithImpl<$Res, PaginateProfileState>;
  @useResult
  $Res call(
      {List<Profile> profiles,
      bool loading,
      bool moreLoading,
      List<String> interests});
}

/// @nodoc
class _$PaginateProfileStateCopyWithImpl<$Res,
        $Val extends PaginateProfileState>
    implements $PaginateProfileStateCopyWith<$Res> {
  _$PaginateProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profiles = null,
    Object? loading = null,
    Object? moreLoading = null,
    Object? interests = null,
  }) {
    return _then(_value.copyWith(
      profiles: null == profiles
          ? _value.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<Profile>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      moreLoading: null == moreLoading
          ? _value.moreLoading
          : moreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaginateProfileStateCopyWith<$Res>
    implements $PaginateProfileStateCopyWith<$Res> {
  factory _$$_PaginateProfileStateCopyWith(_$_PaginateProfileState value,
          $Res Function(_$_PaginateProfileState) then) =
      __$$_PaginateProfileStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Profile> profiles,
      bool loading,
      bool moreLoading,
      List<String> interests});
}

/// @nodoc
class __$$_PaginateProfileStateCopyWithImpl<$Res>
    extends _$PaginateProfileStateCopyWithImpl<$Res, _$_PaginateProfileState>
    implements _$$_PaginateProfileStateCopyWith<$Res> {
  __$$_PaginateProfileStateCopyWithImpl(_$_PaginateProfileState _value,
      $Res Function(_$_PaginateProfileState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profiles = null,
    Object? loading = null,
    Object? moreLoading = null,
    Object? interests = null,
  }) {
    return _then(_$_PaginateProfileState(
      profiles: null == profiles
          ? _value._profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<Profile>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      moreLoading: null == moreLoading
          ? _value.moreLoading
          : moreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_PaginateProfileState implements _PaginateProfileState {
  _$_PaginateProfileState(
      {final List<Profile> profiles = const [],
      this.loading = true,
      this.moreLoading = false,
      final List<String> interests = const []})
      : _profiles = profiles,
        _interests = interests;

  final List<Profile> _profiles;
  @override
  @JsonKey()
  List<Profile> get profiles {
    if (_profiles is EqualUnmodifiableListView) return _profiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profiles);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool moreLoading;
  final List<String> _interests;
  @override
  @JsonKey()
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  @override
  String toString() {
    return 'PaginateProfileState(profiles: $profiles, loading: $loading, moreLoading: $moreLoading, interests: $interests)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaginateProfileState &&
            const DeepCollectionEquality().equals(other._profiles, _profiles) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.moreLoading, moreLoading) ||
                other.moreLoading == moreLoading) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_profiles),
      loading,
      moreLoading,
      const DeepCollectionEquality().hash(_interests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaginateProfileStateCopyWith<_$_PaginateProfileState> get copyWith =>
      __$$_PaginateProfileStateCopyWithImpl<_$_PaginateProfileState>(
          this, _$identity);
}

abstract class _PaginateProfileState implements PaginateProfileState {
  factory _PaginateProfileState(
      {final List<Profile> profiles,
      final bool loading,
      final bool moreLoading,
      final List<String> interests}) = _$_PaginateProfileState;

  @override
  List<Profile> get profiles;
  @override
  bool get loading;
  @override
  bool get moreLoading;
  @override
  List<String> get interests;
  @override
  @JsonKey(ignore: true)
  _$$_PaginateProfileStateCopyWith<_$_PaginateProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
