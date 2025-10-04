import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/features/auth/ui/screens/auth_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/forgot_password_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/otp_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/reset_password_screen.dart';
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
        GoRoute(
          path: Routes.auth,
          name: Routes.auth,
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: Routes.forgetPassword,
          name: Routes.forgetPassword,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: Routes.otpScreen,
          name: Routes.otpScreen,
          builder: (context, state) => const OtpScreen(),
        ),
        GoRoute(
          path: Routes.resetPassword,
          name: Routes.resetPassword,
          builder: (context, state) => const ResetPasswordScreen(),
        ),
        GoRoute(
          path: Routes.completeProfile,
          name: Routes.completeProfile,
          builder: (context, state) => const CompleteProfileScreen(),
        ),
      ],
      errorBuilder:
          (context, state) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
    );
  }
}
