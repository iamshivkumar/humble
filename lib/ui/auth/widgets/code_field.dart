// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:kisan/ui/auth/providers/auth_provider.dart';
// import 'package:pinput/pinput.dart';

// import '../../components/snackbar.dart';
// import '../../root.dart';

// class CodeField extends HookConsumerWidget {
//   const CodeField({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = Theme.of(context);
//     final scheme = theme.colorScheme;
//     final controller = useTextEditingController();
//     final model = ref.watch(authProvider);

//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: TextStyle(
//         fontSize: 22,
//         color: scheme.onSurface,
//       ),
//       decoration: BoxDecoration(
//         color: scheme.surface,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: scheme.outline),
//         boxShadow: [
//           BoxShadow(color: scheme.outline, offset: Offset(2, 2)),
//         ],
//       ),
//     );
//     return Pinput(
//       autofocus: true,
//       length: 6,
//       controller: controller,
//       defaultPinTheme: defaultPinTheme,
//       onCompleted: (pin) async {
//         try {
//           await model.validatePhone(pin);
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             Root.route,
//             (route) => false,
//           );
//         } catch (e) {
//           controller.clear();
//           AppSnackbar(context).error(e);
//         }
//       },
//       onChanged: (value) {
//         debugPrint('onChanged: $value');
//       },
//       cursor: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 9),
//             width: 22,
//             height: 1,
//             color: scheme.primary,
//           ),
//         ],
//       ),
//       focusedPinTheme: defaultPinTheme.copyWith(
//         decoration: defaultPinTheme.decoration!
//             .copyWith(border: Border.all(color: scheme.secondaryContainer), boxShadow: [
//           BoxShadow(
//             color: scheme.secondaryContainer,
//             offset: const Offset(2, 2),
//           ),
//         ]),
//       ),
//       submittedPinTheme: defaultPinTheme.copyWith(
//         decoration: defaultPinTheme.decoration!
//             .copyWith(border: Border.all(color: scheme.primary), boxShadow: [
//           BoxShadow(
//             color: scheme.primary,
//             offset: const Offset(2, 2),
//           ),
//         ]),
//       ),
//       errorPinTheme: defaultPinTheme.copyBorderWith(
//         border: Border.all(color: Colors.redAccent),
//       ),
//     );
//   }
// }
