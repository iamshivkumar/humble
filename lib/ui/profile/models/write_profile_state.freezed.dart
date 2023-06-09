// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'write_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WriteProfileState {
  File? get file => throw _privateConstructorUsedError;
  Profile get profile => throw _privateConstructorUsedError;
  dynamic get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WriteProfileStateCopyWith<WriteProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WriteProfileStateCopyWith<$Res> {
  factory $WriteProfileStateCopyWith(
          WriteProfileState value, $Res Function(WriteProfileState) then) =
      _$WriteProfileStateCopyWithImpl<$Res, WriteProfileState>;
  @useResult
  $Res call({File? file, Profile profile, dynamic loading});
}

/// @nodoc
class _$WriteProfileStateCopyWithImpl<$Res, $Val extends WriteProfileState>
    implements $WriteProfileStateCopyWith<$Res> {
  _$WriteProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = freezed,
    Object? profile = null,
    Object? loading = freezed,
  }) {
    return _then(_value.copyWith(
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      loading: freezed == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WriteProfileStateCopyWith<$Res>
    implements $WriteProfileStateCopyWith<$Res> {
  factory _$$_WriteProfileStateCopyWith(_$_WriteProfileState value,
          $Res Function(_$_WriteProfileState) then) =
      __$$_WriteProfileStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File? file, Profile profile, dynamic loading});
}

/// @nodoc
class __$$_WriteProfileStateCopyWithImpl<$Res>
    extends _$WriteProfileStateCopyWithImpl<$Res, _$_WriteProfileState>
    implements _$$_WriteProfileStateCopyWith<$Res> {
  __$$_WriteProfileStateCopyWithImpl(
      _$_WriteProfileState _value, $Res Function(_$_WriteProfileState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = freezed,
    Object? profile = null,
    Object? loading = freezed,
  }) {
    return _then(_$_WriteProfileState(
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
      profile: null == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      loading: freezed == loading ? _value.loading! : loading,
    ));
  }
}

/// @nodoc

class _$_WriteProfileState implements _WriteProfileState {
  _$_WriteProfileState(
      {this.file, this.profile = const Profile(), this.loading = false});

  @override
  final File? file;
  @override
  @JsonKey()
  final Profile profile;
  @override
  @JsonKey()
  final dynamic loading;

  @override
  String toString() {
    return 'WriteProfileState(file: $file, profile: $profile, loading: $loading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WriteProfileState &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality().equals(other.loading, loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, file, profile, const DeepCollectionEquality().hash(loading));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WriteProfileStateCopyWith<_$_WriteProfileState> get copyWith =>
      __$$_WriteProfileStateCopyWithImpl<_$_WriteProfileState>(
          this, _$identity);
}

abstract class _WriteProfileState implements WriteProfileState {
  factory _WriteProfileState(
      {final File? file,
      final Profile profile,
      final dynamic loading}) = _$_WriteProfileState;

  @override
  File? get file;
  @override
  Profile get profile;
  @override
  dynamic get loading;
  @override
  @JsonKey(ignore: true)
  _$$_WriteProfileStateCopyWith<_$_WriteProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
