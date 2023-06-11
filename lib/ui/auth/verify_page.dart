// ignore_for_file: unused_result, use_build_context_synchronously

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore: depend_on_referenced_packages
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/auth/providers/auth_view_model.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';
import '../utils/labels.dart';
import 'providers/user_provider.dart';

class EmailVerifyPage extends HookConsumerWidget {
  const EmailVerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final styles = theme.textTheme;
    final notifier = ref.read(authNotifierProvider.notifier);
    final email = ref.read(userProvider).value!.email;

    void onDone() {
      context.pushReplacement(Routes.root);
    }

    useOnAppLifecycleStateChange((previous, current) async {
      if (previous == AppLifecycleState.paused &&
          current == AppLifecycleState.resumed) {
        final user = await ref.refresh(userProvider.future);
        if (user.emailVerification) {
          onDone();
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(Labels.verifyYouEmail),
        actions: [
          TextButton(
            onPressed: () async {
              await notifier.logout();
              onDone();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              Labels.verificationEmailLink(email),
              textAlign: TextAlign.center,
              style: styles.bodyLarge,
            ),
            const Spacer(),
            // Expanded(
            //   flex: 4,
            //   child: SvgPicture.asset(
            //     Assets.emailVerify,
            //   ),
            // ),
            const Spacer(),
            MaterialButton(
              onPressed: () async {
                final v = await ref.refresh(userProvider.future);
                if (!v.emailVerification) {
                  onDone();
                } else {}
              },
              child: const Text('Done'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                try {
                  await notifier.sendVerificationEmail();
                  context.message(Labels.verificationEmailResent);
                } on AppwriteException catch (e) {
                  context.error(e.message ?? e.code ?? e);
                }
              },
              child: const Text(
                'Resend email',
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
