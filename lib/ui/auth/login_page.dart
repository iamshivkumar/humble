// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:humble/ui/auth/providers/auth_view_model.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';
import '../components/loading_layer.dart';
import '../utils/labels.dart';
import '../utils/validators.dart';
import 'widgets/google_button.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(authNotifierProvider.notifier);
    final model = ref.watch(authNotifierProvider);
    return PageLoadingLayer(
      loading: model.loading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(Labels.appName),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Email',
                    style: context.style.bodyLarge,
                  ),
                  // const SizedBox(height: 8),
                  TextFormField(
                    initialValue: model.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'you@example.com',
                    ),
                    onChanged: notifier.emailChanged,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Password',
                    style: context.style.bodyLarge,
                  ),
                  // const SizedBox(height: 8),
                  TextFormField(
                    obscureText: model.obscurePassword,
                    initialValue: model.password,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      hintText: 'at least 6 characters',
                      suffixIcon: IconButton(
                        onPressed: notifier.toggleObscurePassword,
                        icon: Icon(model.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    ),
                    onChanged: notifier.passwordChanged,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoButton(
                      onPressed: () {
                        context.push(Routes.resetPassword);
                      },
                      child: const Text(Labels.forgotPassword),
                    ),
                  ),
                  const SizedBox(height: 8),
                  MaterialButton(
                    elevation: 0,
                    disabledColor: context.scheme.outlineVariant.withOpacity(0.5),
                    color: context.scheme.primaryContainer,
                    textColor: context.scheme.onPrimaryContainer,
                    onPressed:
                        model.email.isNotEmpty && model.password.isNotEmpty
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await notifier.login();
                                    context.pushReplacement(Routes.root);
                                  } catch (e) {
                                    context.error(e);
                                  }
                                }
                              }
                            : null,
                    child: Text(Labels.signIn.toUpperCase()),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    Labels.or,
                    style: context.style.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const GoogleButton(),
                  const SizedBox(height: 24),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: Labels.dontHaveAnAccount,
                      style: context.style.bodyLarge,
                      children: [
                        TextSpan(
                            text: Labels.signUp,
                            style: context.style.bodyLarge!.copyWith(
                              color: context.scheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(Routes.signUp);
                              }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
