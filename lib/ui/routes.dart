import 'package:go_router/go_router.dart';
import 'package:humble/ui/auth/register_page.dart';
import 'package:humble/ui/auth/reset_password_page.dart';
import 'package:humble/ui/chat/chat_page.dart';
import 'package:humble/ui/profile/models/profile.dart';
import 'package:humble/ui/profile/profile_page.dart';
import 'package:humble/ui/profile/write_profile_page.dart';
import 'package:humble/ui/root.dart';
import 'package:humble/ui/splash/splash_page.dart';

class Routes {
  static GoRouter router = GoRouter(
    // initialLocation: '/splash',
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const Root(),
        routes: [
          GoRoute(
            path: 'profile',
            builder: (context, state) => ProfilePage(
              profile: state.extra as Profile,
            ),
          ),
          GoRoute(
            path: 'write_profile',
            builder: (context, state) => const WriteProfilePage(),
          ),
          GoRoute(
            path: 'sign-up',
            builder: (context, state) => RegisterPage(),
          ),
          GoRoute(
            path: 'reset_password',
            builder: (context, state) => ResetPasswordPage(),
          ),
          GoRoute(
            path: 'chat',
            builder: (context, state) => ChatPage(
              receiverId: state.extra as String,
            ),
          ),
        ],
      ),
    ],
  );

  static const splash = "/splash";
  static const root = "/";
  static const profile = "/profile";
  static const signUp = "/sign-up";
  static const resetPassword = "/reset_password";
  static const chat = "/chat";
  static const chatRoot = "/profile/chat-root";
  static const writeProfile = "/write_profile";
}
