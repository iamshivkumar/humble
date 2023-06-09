import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:humble/ui/auth/providers/auth_view_model.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/extensions.dart';
import '../components/loading_layer.dart';
import '../utils/validators.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);
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
          title: const Text('Let\'s get started'),
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
                    'Name',
                    style: context.style.bodyLarge,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    initialValue: model.name,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        hintText: 'Your name'),
                    onChanged: notifier.nameChanged,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Email',
                    style: context.style.bodyLarge,
                  ),
                  TextFormField(
                    initialValue: model.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'you@example.com'),
                    onChanged: notifier.emailChanged,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Password',
                    style: context.style.bodyLarge,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: model.obscurePassword,
                    initialValue: model.password,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      hintText: 'At least 6 characters',
                      suffixIcon: IconButton(
                        onPressed: notifier.toggleObscurePassword,
                        icon: Icon(model.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    ),
                    onChanged: notifier.passwordChanged,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 32),
                  MaterialButton(
                    elevation: 0,
                    disabledColor: context.scheme.outlineVariant.withOpacity(0.5),
                    color: context.scheme.primaryContainer,
                    textColor: context.scheme.onPrimaryContainer,
                    onPressed: model.name.isNotEmpty &&
                            model.email.isNotEmpty &&
                            model.password.isNotEmpty
                        ? () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await notifier.register();
                                // ignore: use_build_context_synchronously
                                context.push(Routes.root);
                              } catch (e) {
                                context.error(e);
                              }
                            }
                          }
                        : null,
                    child: const Text(
                      "Create Account",
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
