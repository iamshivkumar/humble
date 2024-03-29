import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:humble/core/enums/attachment_type.dart';
import 'package:humble/core/providers/theme_mode_provider.dart';
import 'package:humble/firebase_options.dart';
import 'package:humble/ui/chat/models/attachment.dart';
import 'package:humble/ui/chat/models/message.dart';
import 'package:humble/ui/routes.dart';
import 'package:humble/ui/utils/labels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(AttachmentAdapter());
  Hive.registerAdapter(AttachmentTypeAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFF02D64),
    );
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFF02D64),
      brightness: Brightness.dark,
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: Labels.appName,
      themeMode: ref.watch(themeModeProvider).asData?.value,
      theme: ThemeData(
        scaffoldBackgroundColor: lightColorScheme.surface,
        colorScheme: lightColorScheme,
        useMaterial3: true,
        buttonTheme: const ButtonThemeData(shape: StadiumBorder()),
        inputDecorationTheme: const InputDecorationTheme(),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkColorScheme.surface,
        colorScheme: darkColorScheme,
        useMaterial3: true,
        buttonTheme: const ButtonThemeData(shape: StadiumBorder()),
        inputDecorationTheme: const InputDecorationTheme(),
      ),
      routerConfig: Routes.router,
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
