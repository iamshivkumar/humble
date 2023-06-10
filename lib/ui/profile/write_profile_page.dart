// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/enums/gender.dart';
import 'package:humble/core/utils/extensions.dart';
import 'package:humble/core/utils/interests.dart';
import 'package:humble/ui/auth/widgets/primary_button.dart';
import 'package:humble/ui/profile/widgets/avatar_editor.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/dates.dart';
import 'package:humble/ui/utils/extensions.dart';

import '../components/loading_layer.dart';
import '../utils/labels.dart';
import '../utils/validators.dart';
import 'providers/write_profile_notifier.dart';

class WriteProfilePage extends HookConsumerWidget {
  const WriteProfilePage({super.key});

  static const route = "/write-profile";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useRef(GlobalKey<FormState>());
    final model = ref.watch(writeProfileNotifierProvider);
    final notifier = ref.watch(writeProfileNotifierProvider.notifier);

    final controller = useScrollController();

    return PageLoadingLayer(
      loading: model.loading,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title:  Text("${notifier.edit?'Edit':'Create'} your profile"),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: PrimaryButton(
                onPressed: () async {
                  if (model.profile.image == null && model.file == null) {
                    return context.error('Pick your profile image!');
                  }
                  if (formKey.value.currentState!.validate()) {
                    formKey.value.currentState!.save();
                    if (model.profile.interests.isEmpty) {
                      return context
                          .error('Select your interests to continue!');
                    }
                    try {
                      await notifier.write();
                      context.pushReplacement(Routes.root);
                    } catch (e) {
                      context.error(e);
                    }
                  }
                },
                label: Labels.save,
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: controller,
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarEditor(
                    onChanged: (v) {
                      notifier.setFile(v);
                    },
                    file: model.file,
                    image: model.profile.image,
                  ),
                  const SizedBox(height: 16),
                  const Text("Name"),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    initialValue: model.profile.name,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        hintText: 'Your name'),
                    onChanged: notifier.nameChanged,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 16),
                  const Text("Gender"),
                  Row(
                    children: Gender.values
                        .map(
                          (e) => Row(
                            children: [
                              Radio(
                                value: e,
                                groupValue: model.profile.gender,
                                onChanged: (v) {
                                  notifier.genderChanged(v!);
                                },
                              ),
                              Text(e.name.capitalize),
                              const SizedBox(width: 16),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text("Date Of Birth"),
                  TextFormField(
                    readOnly: true,
                    key: ValueKey(model.profile.dateOfBirth),
                    initialValue: model.profile.dateOfBirth?.formatDate,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.calendar),
                      hintText: '',
                    ),
                    validator: Validators.required,
                    onTap: () async {
                      final v = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(Dates.now.year - 18),
                      );
                      if (v != null) {
                        notifier.dateOfBirthChanged(v);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Occupation"),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    initialValue: model.profile.occupation,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      hintText: 'i.e. Developer/Student',
                    ),
                    onChanged: notifier.occupationChanged,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 16),
                  const Text('Interests'),
                  Wrap(
                    spacing: 8,
                    children: Interests.data.entries
                        .map(
                          (e) => ChoiceChip(
                            label: Text(e.value),
                            selected: model.profile.interests.contains(e.key),
                            onSelected: (_) {
                              notifier.toggleInterest(e.key);
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text("Tell us more about yourself"),
                  TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    initialValue: model.profile.description,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.info_outline_rounded),
                      hintText: 'Description (optional)',
                    ),
                    onChanged: notifier.descriptionChanged,
                  ),
                  const SizedBox(height: 16),
                  const Text("Location"),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    initialValue: model.profile.location,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      hintText: 'City, Country',
                    ),
                    onChanged: notifier.locationChanged,
                    validator: Validators.required,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
