import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/labels.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
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
