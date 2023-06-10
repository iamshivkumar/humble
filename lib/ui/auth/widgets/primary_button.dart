import 'package:flutter/material.dart';
import 'package:humble/ui/utils/extensions.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: context.scheme.outlineVariant.withOpacity(0.5),
      color: context.scheme.primary,
      textColor: context.scheme.onPrimary,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
