import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_cubit.dart';
import 'package:doctor_mate/features/appointment_details/logic/cubit/appointment_details_cubit.dart';
import 'package:doctor_mate/features/appointment_details/ui/appointment_details_screen.dart';
import 'package:doctor_mate/features/appointment/ui/reschedule_appointment_screen.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_cubit.dart';
import 'package:doctor_mate/features/booking_appointment/ui/appointment_screen.dart';
import 'package:doctor_mate/features/booking_appointment/ui/payment_webview_screen.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/appointment_success_screen.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/chat/logic/communication_cubit.dart';
import 'package:doctor_mate/features/chat/ui/agora_call_screen.dart';
import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';
import 'package:doctor_mate/features/details/logic/cubit/details_cubit.dart';
import 'package:doctor_mate/features/auth/ui/screens/auth_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/forgot_password_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/otp_screen.dart';
import 'package:doctor_mate/features/auth/ui/screens/reset_password_screen.dart';
import 'package:doctor_mate/features/details/ui/details_screen.dart';
import 'package:doctor_mate/features/dignoses/ui/dignoses_screen.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:doctor_mate/features/main_navigation/logic/cubit/main_cubit.dart';
import 'package:doctor_mate/features/main_navigation/ui/main_navigation_screen.dart';
import 'package:doctor_mate/features/medical-record/logic/cubit/medical_records_cubit.dart';
import 'package:doctor_mate/features/medical-record/ui/medical_record_screen.dart';
import 'package:doctor_mate/features/notifications/logic/notifications_cubit.dart';
import 'package:doctor_mate/features/notifications/ui/notifications_screen.dart';
import 'package:doctor_mate/features/onBoarding/ui/onBoarding_screen.dart';
import 'package:doctor_mate/features/prescriptions/logic/cubit/prescriptions_cubit.dart';
import 'package:doctor_mate/features/prescriptions/ui/prescriptions_screen.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_cubit.dart';
import 'package:doctor_mate/features/profile/logic/cubit/security_cubit.dart';
import 'package:doctor_mate/features/profile/logic/cubit/contact_cubit.dart';
import 'package:doctor_mate/features/profile/data/models/profile_response_model.dart';
import 'package:doctor_mate/features/profile/ui/screens/edit_profile_screen.dart';
import 'package:doctor_mate/features/profile/ui/profile_screen.dart';
import 'package:doctor_mate/features/profile/ui/screens/security_screen.dart';
import 'package:doctor_mate/features/profile/ui/screens/payment_history_screen.dart';
import 'package:doctor_mate/features/profile/ui/screens/notifications_settings_screen.dart';
import 'package:doctor_mate/features/profile/ui/screens/help_center_screen.dart';
import 'package:doctor_mate/features/profile/ui/screens/contact_us_screen.dart';
import 'package:doctor_mate/features/profile/ui/screens/terms_conditions_screen.dart';
import 'package:doctor_mate/features/profile/ui/screens/privacy_policy_screen.dart';
import 'package:doctor_mate/features/qr_scanner/ui/qr_scanner_screen.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_cubit.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/smart_check_response.dart';
import 'package:doctor_mate/features/smart-checkup/logic/cubit/smart_checkup_cubit.dart';
import 'package:doctor_mate/features/smart-checkup/ui/smart_checkup_result_screen.dart';
import 'package:doctor_mate/features/smart-checkup/ui/smart_checkup_screen.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:doctor_mate/features/chat/ui/chat_conversation_screen_firestore.dart';
import 'package:doctor_mate/features/chat/ui/chat_screen.dart';
import 'package:doctor_mate/features/search/logic/cubit/search_cubit.dart';
import 'package:doctor_mate/features/search/ui/search_screen.dart';
import 'package:doctor_mate/features/home/ui/view_all/view_all_screen.dart';
import 'package:doctor_mate/features/splash/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctor_mate/features/profile/logic/payment_history_cubit/payment_history_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // Static router instance
  static GoRouter? _router;

  static GoRouter get router {
    _router ??= _createRouter();
    return _router!;
  }

  static GoRouter _createRouter() {
    return GoRouter(
      initialLocation: Routes.splash,
      routes: [
        GoRoute(
          path: Routes.profileScreen,
          name: Routes.profileScreen,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: Routes.editProfileScreen,
          name: Routes.editProfileScreen,
          builder: (context, state) {
            final profile = state.extra as ProfileResponseModel;
            return BlocProvider(
              create: (context) => getIt<ProfileCubit>(),
              child: EditProfileScreen(profile: profile),
            );
          },
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
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<MainCubit>(),
              child: MainNavigationScreen(initialIndex: state.extra as int?),
            );
          },
        ),
        GoRoute(
          path: Routes.detailsScreen,
          name: Routes.detailsScreen,
          builder: (context, state) {
            final doctorId = state.extra as String?;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (context) =>
                          getIt<DetailsCubit>()
                            ..getDoctorDetails(doctorId: doctorId ?? ''),
                ),
                BlocProvider(create: (context) => getIt<ReviewsCubit>()),
              ],
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
            return BlocProvider(
              create: (context) => getIt<AppointmentCubit>(),
              child: AppointmentSuccessScreen(appointmentData: appointmentData),
            );
          },
        ),
        GoRoute(
          path: Routes.rescheduleAppointment,
          name: Routes.rescheduleAppointment,
          builder: (context, state) {
            final appointment = state.extra as PatientAppointmentModel;
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<AppointmentCubit>()),
                BlocProvider.value(value: getIt<AppointmentManageCubit>()),
              ],
              child: RescheduleAppointmentScreen(appointment: appointment),
            );
          },
        ),
        GoRoute(
          path: Routes.appointmentDetails,
          name: Routes.appointmentDetails,
          builder: (context, state) {
            // Get appointmentId from either query parameters or extra object
            final String appointmentId;

            if (state.extra != null && state.extra is PatientAppointmentModel) {
              // Coming from appointment list with full object
              final appointment = state.extra as PatientAppointmentModel;
              appointmentId = appointment.id.toString();
            } else {
              // Coming from notification or deep link with just ID
              appointmentId = state.uri.queryParameters['appointmentId'] ?? '';
            }

            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<CommunicationCubit>()),
                BlocProvider(
                  create: (context) => getIt<AppointmentDetailsCubit>(),
                ),
                BlocProvider(create: (context) => getIt<ReviewsCubit>()),
              ],
              child: AppointmentDetailsScreen(appointmentId: appointmentId),
            );
          },
        ),
        GoRoute(
          path: Routes.dignosesScreen,
          name: Routes.dignosesScreen,
          builder: (context, state) {
            final recordId = state.uri.queryParameters['recordId'] ?? '';
            final diagnosisData = state.extra as DiagnosisModel?;
            return DiagnosesScreen(
              recordId: recordId,
              diagnosisData: diagnosisData,
            );
          },
        ),
        GoRoute(
          path: Routes.prescriptionsScreen,
          name: Routes.prescriptionsScreen,
          builder: (context, state) {
            final diagnosisId = state.uri.queryParameters['diagnosisId'];
            final appointmentId = state.uri.queryParameters['appointmentId'];
            final prescriptionId = state.uri.queryParameters['prescriptionId'];
            return BlocProvider(
              create: (context) => getIt<PrescriptionsCubit>(),
              child: PrescriptionsScreen(
                diagnosisId: diagnosisId,
                appointmentId: appointmentId,
                prescriptionId: prescriptionId,
              ),
            );
          },
        ),
        GoRoute(
          path: Routes.smartCheckupScreen,
          name: Routes.smartCheckupScreen,
          builder:
              (context, state) => BlocProvider(
                create: (context) => getIt<SmartCheckupCubit>(),
                child: const SmartCheckupScreen(),
              ),
        ),
        GoRoute(
          path: Routes.smartCheckupResultScreen,
          name: Routes.smartCheckupResultScreen,
          builder: (context, state) {
            final checkupResult = state.extra as SmartCheckResponse;
            final checkType =
                state.uri.queryParameters['checkType'] ?? 'symptom';
            return BlocProvider(
              create: (context) => getIt<SmartCheckupCubit>(),
              child: SmartCheckupResultScreen(
                checkupResult: checkupResult,
                checkType: checkType,
              ),
            );
          },
        ),
        GoRoute(
          path: Routes.chatScreen,
          name: Routes.chatScreen,
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: Routes.chatConversationScreen,
          name: Routes.chatConversationScreen,
          builder: (context, state) {
            final conversation = state.extra as ChatConversationResponse?;
            return ChatConversationScreenFirestore(
              conversation:
                  conversation ??
                  ChatConversationResponse(id: 'default', doctorName: 'Doctor'),
            );
          },
        ),
        GoRoute(
          path: Routes.searchScreen,
          name: Routes.searchScreen,
          builder:
              (context, state) => BlocProvider(
                create: (context) => getIt<SearchCubit>(),
                child: const SearchScreen(),
              ),
        ),
        GoRoute(
          path: Routes.viewAllScreen,
          name: Routes.viewAllScreen,
          builder: (context, state) {
            final specialtyId = state.extra as String?;
            return BlocProvider(
              create: (context) => getIt<SearchCubit>(),
              child: ViewAllScreen(specialtyId: specialtyId),
            );
          },
        ),
        GoRoute(
          path: Routes.medicalRecordScreen,
          name: Routes.medicalRecordScreen,
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<AppointmentManageCubit>(),
                ),
                BlocProvider(
                  create:
                      (context) =>
                          getIt<MedicalRecordsCubit>()
                            ..getPatientMedicalRecords(page: 1, limit: 10),
                ),
              ],
              child: MedicalRecordScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.notificationsScreen,
          name: Routes.notificationsScreen,
          builder:
              (context, state) => BlocProvider(
                create:
                    (context) =>
                        getIt<NotificationsCubit>()..getNotifications(),
                child: const NotificationsScreen(),
              ),
        ),
        GoRoute(
          path: Routes.qrScannerScreen,
          name: Routes.qrScannerScreen,
          builder: (context, state) => const QrScannerScreen(),
        ),
        GoRoute(
          path: Routes.agoraCallScreen,
          name: Routes.agoraCallScreen,
          builder: (context, state) {
            final token = state.uri.queryParameters['token'];
            final channel = state.uri.queryParameters['channel'];
            final callType = state.uri.queryParameters['callType'];
            return AgoraCallScreen(
              token: token!,
              channelName: channel!,
              callType: callType!,
            );
          },
        ),
        GoRoute(
          path: Routes.paymentWebviewScreen,
          name: Routes.paymentWebviewScreen,
          builder: (context, state) {
            final params = state.extra as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => getIt<AppointmentCubit>(),
              child: PaymentWebViewScreen(
                paymentUrl: params['paymentUrl'] as String,
                appointment: params['appointment'] as AppointmentModel,
                paymentId: params['paymentId'] as String,
              ),
            );
          },
        ),
        GoRoute(
          path: Routes.securityScreen,
          name: Routes.securityScreen,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => SecurityCubit(),
              child: const SecurityScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.paymentHistoryScreen,
          name: Routes.paymentHistoryScreen,
          builder:
              (context, state) => BlocProvider(
                create:
                    (context) => getIt<PaymentHistoryCubit>()..getMyPayments(),
                child: const PaymentHistoryScreen(),
              ),
        ),
        GoRoute(
          path: Routes.notificationsSettingsScreen,
          name: Routes.notificationsSettingsScreen,
          builder: (context, state) => const NotificationsSettingsScreen(),
        ),
        GoRoute(
          path: Routes.helpCenterScreen,
          name: Routes.helpCenterScreen,
          builder: (context, state) => const HelpCenterScreen(),
        ),
        GoRoute(
          path: Routes.contactUsScreen,
          name: Routes.contactUsScreen,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => ContactCubit(),
              child: const ContactUsScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.termsConditionsScreen,
          name: Routes.termsConditionsScreen,
          builder: (context, state) => const TermsConditionsScreen(),
        ),
        GoRoute(
          path: Routes.privacyPolicyScreen,
          name: Routes.privacyPolicyScreen,
          builder: (context, state) => const PrivacyPolicyScreen(),
        ),
      ],
      errorBuilder:
          (context, state) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
    );
  }

  // Backward compatibility method
  static GoRouter mainRouting() => router;
}
