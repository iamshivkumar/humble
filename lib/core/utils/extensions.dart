import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

extension OnUser on User {
  String get initial => name.initial;
}

extension OnString on String {
  String get initial {
    final chars = split(' ')
        .where((element) => element.isNotEmpty)
        .map((e) => e.characters.first)
        .join();

    return chars.length > 2 ? "${chars[0]}${chars[2]}" : chars;
  }

  String get capitalize => split('').length > 1
      ? '${split('').first.toUpperCase()}${split('').sublist(1).join()}'
      : this;
}

extension StringNull on String {
  String? get crim => isEmpty ? null : this;
  String get ending => split('.').last;
}

extension FileExtension on io.File {
  String get ending => path.split('.').last;
}
