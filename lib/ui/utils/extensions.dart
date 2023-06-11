import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'dates.dart';

extension OnDateTime on DateTime {
  String get formatTime => DateFormat('hh:mm a').format(this);
  String get formatDate => DateFormat('dd MMM yyyy').format(this);

  DateTime get date => DateTime(year, month, day);

  String get formatDateTime => DateFormat('dd MMM yyyy hh:mm a').format(this);

  String get labelDateTime {
    final bool today = year == Dates.today.year &&
        month == Dates.today.month &&
        day == Dates.today.day;

    final bool tomorrow = year == Dates.tomorrow.year &&
        month == Dates.tomorrow.month &&
        day == Dates.tomorrow.day;

    String date() {
      if (today) {
        return "Today";
      } else if (tomorrow) {
        return "Tomorrow";
      } else {
        return formatDate;
      }
    }

    return "${date()} at $formatTime";
  }

  String get time => DateFormat("hh:mm a").format(this);

  String get monthDay => DateFormat(DateFormat.MONTH_DAY).format(this);

  String get monthDaySimple => DateFormat("d MMM").format(this);

  String get monthLabel => DateFormat("MMM").format(this);
}

extension OnBuildContext on BuildContext {
  void fly(String name, {Object? extra}) {
    final state = GoRouterState.of(this);
    push("${state.location}/$name", extra: extra);
  }

  MediaQueryData get media => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);
  TextTheme get style => theme.textTheme;
  ColorScheme get scheme => theme.colorScheme;
  // CustomColors get colors => theme.extension<CustomColors>()!;

  void error(Object e) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          "$e",
          style: style.bodyLarge!.copyWith(
            color: scheme.errorContainer,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.onErrorContainer,
      ),
    );
  }

  void message(Object e) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          "$e",
          style: style.bodyLarge!.copyWith(
            color: scheme.primaryContainer,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.onPrimaryContainer,
      ),
    );
  }

  BoxDecoration get outlinedBoxDecoration => BoxDecoration(
        color: scheme.surface,
        border: Border.all(
          color: scheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(12),
      );

  void openImage(String path) {
    Navigator.of(this).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SafeArea(
              child: Image.file(
                File(path),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> pickAndCrop([double? aspectRatio, ImageSource? source]) async {
    try {
      final file =
          await ImagePicker().pickImage(source: source ?? ImageSource.gallery);
      if (file != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          maxHeight: 512,
          maxWidth: 512,
          sourcePath: file.path,
          aspectRatio: CropAspectRatio(ratioX: (aspectRatio ?? 1), ratioY: 1),
          uiSettings: [],
        );
        return croppedFile != null ? File(croppedFile.path) : null;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
