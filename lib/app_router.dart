import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/home_page.dart';

CustomTransitionPage<void> _fadePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 420),
    reverseTransitionDuration: const Duration(milliseconds: 420),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeIn = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInOutCubic,
      );

      final fadeOut = CurvedAnimation(
        parent: secondaryAnimation,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInOutCubic,
      );

      return FadeTransition(
        opacity: Tween<double>(begin: 1, end: 0).animate(fadeOut),
        child: FadeTransition(opacity: fadeIn, child: child),
      );
    },
  );
}

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: false,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          _fadePage(state: state, child: const HomePage()),
    ),
    GoRoute(
      path: '/about',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          _fadePage(state: state, child: const AboutPage()),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          _fadePage(state: state, child: const ContactPage()),
    ),
  ],
);
