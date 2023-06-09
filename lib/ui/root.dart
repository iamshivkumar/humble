import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/auth/login_page.dart';
import 'package:humble/ui/dashboard/dashboard.dart';
import 'package:humble/ui/profile/providers/my_profile_provider.dart';
import 'package:humble/ui/profile/write_profile_page.dart';
import 'auth/providers/user_provider.dart';
import 'auth/verify_page.dart';

class Root extends ConsumerWidget {
  const Root({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.read(userProvider).when(
          data: (user) => user.emailVerification
              ? ref.watch(profileProvider).when(
                    data: (profile) => const Dashboard(),
                    error: (e, s) {
                      return const WriteProfilePage();
                    },
                    loading: () => const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
              :  const EmailVerifyPage(),
          error: (e, s) => LoginPage(),
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}
