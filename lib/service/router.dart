import 'package:egoism/screen/animation_screen.dart';
import 'package:egoism/screen/emotion_screen.dart';
import 'package:egoism/screen/login_screen.dart';
import 'package:egoism/screen/menu_screen.dart';
import 'package:egoism/screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final _routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const MenuScreen(),
  ),
  GoRoute(
      path: '/login',
      // builder: (context, state) => const LoginScreen(),
      pageBuilder: (context, state) => CustomTransitionPage(
          child: const LoginScreen(),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
          fullscreenDialog: true)),
  GoRoute(
    path: '/emotion',
    builder: (context, state) => const EmotionAnalysisScreen(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) => const ProfileScreen(),
  ),
  GoRoute(
    path: '/animation',
    builder: (context, state) => const AnimationScreen(),
  ),
];

class CustomRouter {
  static GoRouter router = GoRouter(initialLocation: '/', routes: _routes);
}
