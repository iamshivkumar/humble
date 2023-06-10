// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/providers/cache_provider.dart';
import 'package:humble/ui/auth/providers/user_provider.dart';
import 'package:humble/ui/chat/providers/directory_provider.dart';
import 'package:humble/ui/chat/providers/messages_box_provider.dart';
import 'package:humble/ui/profile/providers/my_profile_provider.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';
import 'package:humble/ui/utils/labels.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> init() async {
      try {
        await ref.read(directoryProvider.future);
        await ref.read(cacheProvider.future);
        await ref.read(userProvider.future);
        await ref.read(profileProvider.future);
        await ref.read(messagesBoxProvider.future);
      } catch (e) {
        debugPrint('$e');
      }
      context.go(Routes.root);
    }

    useEffect(() {
      init();
    });
    return Scaffold(
      backgroundColor: context.scheme.primary,
      body: SafeArea(
        child: Center(
          child: Text(
            Labels.appName,
            style: context.style.displayMedium!.copyWith(
              color: context.scheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
