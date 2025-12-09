import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/features/appointment/ui/appointment_management_screen.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_cubit.dart';
import 'package:doctor_mate/features/booking_appointment/ui/appointment_screen.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/appointment_success_screen.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';
import 'package:doctor_mate/features/details/logic/cubit/details_cubit.dart';
import 'package:doctor_mate/features/auth/ui/screens/auth_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/forgot_password_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/otp_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/reset_password_screen.dart';
import 'package:doctor_mate/features/details/ui/details_screen.dart';
import 'package:doctor_mate/features/main_navigation/logic/cubit/main_cubit.dart';
import 'package:doctor_mate/features/main_navigation/ui/main_navigation_screen.dart';
import 'package:doctor_mate/features/onBoarding/ui/onBoarding_screen.dart';
import 'package:doctor_mate/features/profile/ui/profile_screen.dart';
import 'package:doctor_mate/features/splash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter mainRouting() {
    return GoRouter(
      initialLocation: Routes.splash,
      routes: [
        GoRoute(
          path: Routes.profileScreen,
          name: Routes.profileScreen,
          builder: (context, state) => const ProfileScreen(),
        ),
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
          builder:
              (context, state) => BlocProvider(
                create: (context) => getIt<AuthCubit>(),
                child: const AuthScreen(),
              ),
        ),
        GoRoute(
          path: Routes.forgetPassword,
          name: Routes.forgetPassword,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<AuthCubit>(),
              child: const ForgotPasswordScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.otpScreen,
          name: Routes.otpScreen,
          builder: (context, state) {
            var params = state.extra as Map<String, dynamic>?;
            final email = params?['email'] as String?;
            final isForgetPass = params?['isForgetPass'] as bool? ?? false;

            return BlocProvider(
              create: (context) {
                final authCubit = getIt<AuthCubit>();
                // Set the email in the new AuthCubit if provided
                if (email != null) {
                  authCubit.emailController.text = email;
                }
                return authCubit;
              },
              child: OtpScreen(isForgetPass: isForgetPass),
            );
          },
        ),
        GoRoute(
          path: Routes.resetPassword,
          name: Routes.resetPassword,
          builder: (context, state) {
            var params = state.extra as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => getIt<AuthCubit>(),
              child: ResetPasswordScreen(email: params['email'] as String),
            );
          },
        ),
        GoRoute(
          path: Routes.completeProfile,
          name: Routes.completeProfile,
          builder:
              (context, state) => BlocProvider(
                create: (context) => getIt<AuthCubit>(),
                child: const CompleteProfileScreen(),
              ),
        ),
        GoRoute(
          path: Routes.mainLayout,
          name: Routes.mainLayout,
          builder:
              (context, state) => BlocProvider(
                create: (context) => getIt<MainCubit>(),
                child: const MainNavigationScreen(),
              ),
        ),
        GoRoute(
          path: Routes.detailsScreen,
          name: Routes.detailsScreen,
          builder: (context, state) {
            final doctorId = state.extra as String?;
            return BlocProvider(
              create:
                  (context) =>
                      getIt<DetailsCubit>()
                        ..getDoctorDetails(doctorId: doctorId ?? ''),
              child: const DetailsScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.appointmentScreen,
          name: Routes.appointmentScreen,
          builder: (context, state) {
            final doctorDetails = state.extra as DoctorDetailsModel?;
            return BlocProvider(
              create: (context) => getIt<AppointmentCubit>(),
              child: AppointmentScreen(doctorDetails: doctorDetails),
            );
          },
        ),
        GoRoute(
          path: Routes.bookingConfirmation,
          name: Routes.bookingConfirmation,
          builder: (context, state) {
            final appointmentData = state.extra as AppointmentModel?;
            return AppointmentSuccessScreen(appointmentData: appointmentData);
          },
        ),
        GoRoute(
          path: Routes.appointmentManageScreen,
          name: Routes.appointmentManageScreen,
          builder: (context, state) {
            return AppointmentManagementScreen();
          },
        ),
      ],
      errorBuilder:
          (context, state) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
    );
  }
}
