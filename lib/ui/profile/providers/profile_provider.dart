import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/profile/providers/profile_repository_provider.dart';

import '../../auth/providers/user_provider.dart';

final profileProvider = FutureProvider((ref) async {
  final repository = ref.read(profileRepositoryProvider);
  final account = await ref.watch(userProvider.future);
  return repository.getProfile(account.$id);
});
