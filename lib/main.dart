import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/enums/attachment_type.dart';
import 'package:humble/ui/chat/models/attachment.dart';
import 'package:humble/ui/chat/models/message.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/labels.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(AttachmentAdapter());
  Hive.registerAdapter(AttachmentTypeAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const scheme = ColorScheme.highContrastLight(
    //   primary: Colors.pink
    // );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Labels.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF02D64),
        ),
        useMaterial3: true,
        buttonTheme: const ButtonThemeData(shape: StadiumBorder()),
        inputDecorationTheme: const InputDecorationTheme(),
      ),
      routerConfig: Routes.router,
    );
  }
}

/// messages pagination
/// messages sync check
/// chats sync check
/// work on attachments
/// messages seen updates
/// add gender in profile
/// ui finishing




/// [Test]
/// login
/// profile creating
/// profiles pagination
/// chatting
/// edit profile
