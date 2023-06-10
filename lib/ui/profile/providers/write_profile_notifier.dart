// ignore_for_file: unused_result

import 'dart:io';

import 'package:humble/core/enums/gender.dart';
import 'package:humble/core/utils/extensions.dart';
import 'package:humble/ui/auth/providers/user_provider.dart';
import 'package:humble/ui/profile/models/profile.dart';
import 'package:humble/ui/profile/providers/profile_provider.dart';
import 'package:humble/ui/profile/providers/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/write_profile_state.dart';

part 'write_profile_notifier.g.dart';

@riverpod
class WriteProfileNotifier extends _$WriteProfileNotifier {
  @override
  WriteProfileState build() {
    final user = ref.read(userProvider).asData?.value;
    final profile = ref.read(profileProvider).asData?.value;
    return WriteProfileState(
      profile: profile ??
          Profile(
            name: user?.name ?? '',
            id: user?.$id ?? '',
            email: user?.email ?? '',
          ),
    );
  }

  bool get edit => state.profile.image != null;

  void nameChanged(String v) {
    state = state.copyWith(profile: state.profile.copyWith(name: v));
  }

  void genderChanged(Gender v) {
    state = state.copyWith(
      profile: state.profile.copyWith(gender: v),
    );
  }

  void occupationChanged(String v) {
    state = state.copyWith(profile: state.profile.copyWith(occupation: v));
  }

  void locationChanged(String v) {
    state = state.copyWith(profile: state.profile.copyWith(location: v));
  }

  void emailChanged(String v) {
    state = state.copyWith(profile: state.profile.copyWith(email: v));
  }

  void dateOfBirthChanged(DateTime v) {
    state = state.copyWith(profile: state.profile.copyWith(dateOfBirth: v));
  }

  void descriptionChanged(String v) {
    state = state.copyWith(
      profile: state.profile.copyWith(
        description: v.crim,
      ),
    );
  }

  void addInterest(String v) {
    state = state.copyWith(
      profile: state.profile.copyWith(
        interests: [...state.profile.interests, v],
      ),
    );
  }

  void removeInterest(String v) {
    state = state.copyWith(
      profile: state.profile.copyWith(interests: [
        for (final interest in state.profile.interests)
          if (interest != v) interest,
      ]),
    );
  }

  void toggleInterest(String v) {
    if (state.profile.interests.contains(v)) {
      removeInterest(v);
    } else {
      addInterest(v);
    }
  }

  void setFile(File file) {
    state = state.copyWith(file: file);
  }

  ProfileRepository get _repository => ref.read(profileRepositoryProvider);

  Future<void> write() async {
    state = state.copyWith(loading: true);
    try {
      await _repository.writeProfile(state.profile, file: state.file);
      await ref.refresh(profileProvider.future);
    } catch (e) {
      state = state.copyWith(loading: false);
      return Future.error(e);
    }
  }
}
