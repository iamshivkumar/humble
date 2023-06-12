// ignore_for_file: unused_result

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:humble/core/providers/account_provider.dart';
import 'package:humble/core/providers/messaging_provider.dart';
import 'package:humble/ui/auth/models/auth_state.dart';
import 'package:humble/ui/auth/providers/user_provider.dart';
import 'package:humble/ui/profile/providers/profile_provider.dart';
import 'package:humble/ui/profile/providers/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return AuthState();
  }

  Account get _account => ref.read(accountProvider);

  void nameChanged(String e) {
    state = state.copyWith(
      name: e,
    );
  }

  void emailChanged(String e) {
    state = state.copyWith(
      email: e,
    );
  }

  void passwordChanged(String e) {
    state = state.copyWith(
      password: e,
    );
  }

  void newPasswordChanged(String e) {
    state = state.copyWith(
      newPassword: e,
    );
  }

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleObscureNewPassword() {
    state = state.copyWith(obscureNewPassword: !state.obscureNewPassword);
  }

  void toggleObscureConfirmPassword() {
    state =
        state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);
  }

  ProfileRepository get _repository => ref.read(profileRepositoryProvider);

  Future<void> login() async {
    try {
      state = state.copyWith(loading: true);
      await _account.createEmailSession(
        email: state.email,
        password: state.password,
      );
      await ref.refresh(userProvider.future);
      try {
        final profile = await ref.read(profileProvider.future);
        final token = await ref.read(messagingProvider).getToken();
        if (token != null) {
          _repository.updateFcmToken(uid: profile.id, token: token);
        }
      } catch (e) {
        debugPrint('token error $e');
      }
    } on AppwriteException catch (e) {
      state = state.copyWith(loading: false);
      return Future.error(e.message ?? "${e.code}");
    }
  }

  Future<void> register() async {
    try {
      state = state.copyWith(loading: true);

      await _account.create(
        userId: ID.unique(),
        email: state.email,
        password: state.password,
        name: state.name,
      );
      await _account.createEmailSession(
        email: state.email,
        password: state.password,
      );
      await sendVerificationEmail();
      await ref.refresh(userProvider.future);
    } on AppwriteException catch (e) {
      state = state.copyWith(loading: false);
      return Future.error(e.message ?? "${e.code}");
    }
  }

  Future<void> sendVerificationEmail() async {
    await _account.createVerification(url: "https://humble-site.vercel.app/");
  }

  Future<void> sendResetLink() async {
    try {
      state = state.copyWith(loading: true);
      await _account.createRecovery(
        email: state.email,
        url: "https://humble-site.vercel.app/reset-password",
      );
    } on AppwriteException catch (e) {
      state = state.copyWith(loading: false);
      return Future.error(e.message ?? "${e.code}");
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _account.createOAuth2Session(provider: 'google');
      await Future.delayed(const Duration(milliseconds: 500));
      await ref.refresh(userProvider.future);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> logout() async {
     _repository.updateFcmToken(
        uid: ref.read(userProvider).value!.$id, token: null);
    await _account.deleteSessions();
    await ref.refresh(userProvider.future);
  }
}
