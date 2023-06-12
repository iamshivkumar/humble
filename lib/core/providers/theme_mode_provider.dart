import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/providers/cache_provider.dart';

final themeModeProvider = FutureProvider((ref) async {
  final cache = await ref.watch(cacheProvider.future);
  return ThemeMode.values.firstWhere(
    (element) => element.name == cache.getString('theme'),
    orElse: ()=> ThemeMode.light,
  );
});
