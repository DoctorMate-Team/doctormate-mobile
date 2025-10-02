import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/features/onBoarding/ui/onBoarding_screen.dart';
import 'package:doctor_mate/features/splash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter mainRouting() {
    return GoRouter(
      initialLocation: Routes.splash,
      routes: [
        GoRoute(
          path: Routes.splash,
          name: Routes.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: Routes.onBoarding,
          name: Routes.onBoarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
      ],
      errorBuilder:
          (context, state) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
    );
  }
}
