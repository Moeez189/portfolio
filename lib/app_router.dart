import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'constants/app_strings.dart';
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

String? _legacySectionRedirect(GoRouterState state) {
  final path = state.uri.path;
  final normalizedPath = path.startsWith('/') ? path.substring(1) : path;

  if (normalizedPath == AppStrings.fragmentWork ||
      normalizedPath == AppStrings.fragmentServices) {
    return '${AppStrings.routeHome}?section=$normalizedPath';
  }

  return null;
}

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: false,
  redirect: (BuildContext context, GoRouterState state) =>
      _legacySectionRedirect(state),
  routes: <RouteBase>[
    GoRoute(
      path: AppStrings.routeHome,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          _fadePage(state: state, child: const HomePage()),
    ),
    GoRoute(
      path: AppStrings.routeAbout,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          _fadePage(state: state, child: const AboutPage()),
    ),
    GoRoute(
      path: AppStrings.routeContact,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          _fadePage(state: state, child: const ContactPage()),
    ),
    GoRoute(
      path: '/work',
      redirect: (BuildContext context, GoRouterState state) =>
          '${AppStrings.routeHome}?section=${AppStrings.fragmentWork}',
    ),
    GoRoute(
      path: '/services',
      redirect: (BuildContext context, GoRouterState state) =>
          '${AppStrings.routeHome}?section=${AppStrings.fragmentServices}',
    ),
  ],
);
