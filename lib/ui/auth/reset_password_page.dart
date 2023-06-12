// ignore_for_file: use_build_context_synchronously
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/auth/providers/auth_view_model.dart';
import 'package:humble/ui/auth/widgets/primary_button.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../components/loading_layer.dart';
import '../utils/labels.dart';
import '../utils/validators.dart';

class ResetPasswordPage extends HookConsumerWidget {
  ResetPasswordPage({super.key});

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authNotifierProvider.notifier);
    final model = ref.watch(authNotifierProvider);
    return LoadingLayer(
      child: Scaffold(
        backgroundColor: context.scheme.surface,
        appBar: AppBar(
          title: const Text(Labels.forgotYourPassword),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  Labels.enterYourRegisteredEmail,
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    initialValue: model.email,
                    decoration: const InputDecoration(
                      hintText: Labels.email,
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: Validators.email,
                    onChanged: notifier.emailChanged,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                PrimaryButton(
                  onPressed: model.email.isEmpty?null: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await notifier.sendResetLink();
                        context.message(
                          "Reset link sent to ${model.email}",
                        );
                        context.pop();
                      } catch (e) {
                        context.error(e);
                      }
                    }
                  },
                 label: Labels.sendResetLink,
                ),
                const SizedBox(
                  height: 32,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "${Labels.rememberPassword} ",
                    style: context.style.bodyLarge,
                    children: [
                      TextSpan(
                        text: Labels.login,
                        style: TextStyle(
                          color: context.scheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pop();
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
