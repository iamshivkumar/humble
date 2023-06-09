import 'package:flutter/material.dart';
import 'package:humble/ui/utils/extensions.dart';

class InterestMiniTag extends StatelessWidget {
  const InterestMiniTag(this.value, {super.key});

  final String value;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.scheme.surface,
      shape: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 2,
        ),
        child: Text(
          value,
          style: context.style.bodySmall,
        ),
      ),
    );
  }
}


class InterestTag extends StatelessWidget {
  const InterestTag(this.value, {super.key});

  final String value;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.scheme.surfaceVariant,
      shape: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        child: Text(
          value,
          style: TextStyle(
            color: context.scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
