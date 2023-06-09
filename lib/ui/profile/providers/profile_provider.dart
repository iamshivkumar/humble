import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/profile/providers/profile_repository_provider.dart';

import '../models/profile.dart';




final profileInfoProvider = FutureProvider.family<Profile,String>((ref,id) async {
  return ref.read(profileRepositoryProvider).getProfile(id);
});