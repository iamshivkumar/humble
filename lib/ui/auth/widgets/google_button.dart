// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/auth/providers/auth_view_model.dart';
import 'package:humble/ui/routes.dart';

import '../../utils/assets.dart';


class GoogleButton extends ConsumerWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authNotifierProvider.notifier);
    return ElevatedButton.icon(
      onPressed: () async {
        await notifier.signInWithGoogle();
        context.pushReplacement(Routes.root);
      },
      icon: Image.asset(
        Assets.google,
        height: 24,
        width: 24,
      ),
      label: const Text("Continue with Google"),
    );
  }
}
