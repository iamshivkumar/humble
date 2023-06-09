// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/auth/providers/auth_view_model.dart';
import 'package:humble/ui/root.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Column(
        children: [
          Center(
            child: OutlinedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(context.theme.buttonTheme.padding),
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
