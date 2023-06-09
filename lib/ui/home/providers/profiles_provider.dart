import 'package:humble/ui/profile/providers/profile_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../profile/models/profile.dart';

part 'profiles_provider.g.dart';

@riverpod
Future<List<Profile>> profiles (ProfilesRef ref) {
  return ref.read(profileRepositoryProvider).listProfiles();
}