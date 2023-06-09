import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../profile/models/profile.dart';
import '../../profile/providers/profile_provider.dart';

class ProfileBuilder extends ConsumerWidget {
  const ProfileBuilder({super.key, required this.id, required this.builder});

  final String id;
  final Widget Function(Profile profile) builder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    return ref.watch(profileInfoProvider(id)).when(
          data: (profile) => builder(profile),
          error: (e, s) => Text(
            "$e",
            style: style.bodySmall,
          ),
          loading: () => const SizedBox(),
        );
  }
}
