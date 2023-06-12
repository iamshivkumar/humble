// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/providers/cache_provider.dart';
import 'package:humble/core/providers/image_provider.dart';
import 'package:humble/core/providers/theme_mode_provider.dart';
import 'package:humble/core/utils/ids.dart';
import 'package:humble/ui/auth/providers/auth_view_model.dart';
import 'package:humble/ui/profile/providers/profile_provider.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider).value!;
    final image = profile.image != null
        ? ref
            .watch(memoryImageProvider(Buckets.profiles, profile.image!))
            .asData
            ?.value
        : null;
    final themeMode = ref.read(themeModeProvider).asData?.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          if (themeMode != null)
            IconButton(
              onPressed: () async{
              await  ref.read(cacheProvider).value!.setString(
                      'theme',
                      themeMode == ThemeMode.light
                          ? ThemeMode.dark.name
                          : ThemeMode.light.name,
                    );
              ref.refresh(themeModeProvider);
              },
              icon: Icon(themeMode == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.dark_mode),
            )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 56,
                  backgroundImage: image,
                ),
                const SizedBox(height: 8),
                Text(
                  profile.name,
                  style: context.style.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(profile.email),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text("View profile"),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              context.push(Routes.profile, extra: profile);
            },
          ),
          ListTile(
            title: const Text("Edit profile"),
            trailing: const Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              context.push(Routes.writeProfile, extra: profile);
            },
          ),
          const SizedBox(height: 56),
          Center(
            child: OutlinedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    context.theme.buttonTheme.padding),
              ),
              onPressed: () async {
                await ref.read(authNotifierProvider.notifier).logout();
                context.pushReplacement(Routes.root);
              },
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
