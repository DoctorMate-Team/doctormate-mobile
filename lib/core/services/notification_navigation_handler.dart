import 'package:doctor_mate/core/models/notification_data.dart';
import 'package:doctor_mate/core/models/notification_type.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class NotificationNavigationHandler {
  /// Handle navigation based on notification data
  static void handleNotificationNavigation(
    NotificationData data,
    GoRouter router,
  ) {
    debugPrint('Handling navigation for notification: ${data.type.value}');

    // Handle based on click action first
    if (data.clickAction == NotificationClickAction.openMedicalRecord) {
      _navigateToMedicalRecord(data, router);
      return;
    }

    if (data.clickAction == NotificationClickAction.openAppointment) {
      _navigateToAppointment(data, router);
      return;
    }

    if (data.clickAction == NotificationClickAction.openAppointmentDetails) {
      _navigateToAppointmentDetails(data, router);
      return;
    }

    // Handle based on notification type if no specific click action
    switch (data.type) {
      case NotificationType.diagnosisAdded:
        _navigateToDiagnosis(data, router);
        break;

      case NotificationType.appointmentReminder:
      case NotificationType.appointmentConfirmed:
      case NotificationType.appointmentCancelled:
        _navigateToAppointmentDetails(data, router);
        break;

      case NotificationType.prescriptionCreated:
        _navigateToPrescription(data, router);
        break;

      case NotificationType.unknown:
        // Navigate to home or notification center
        router.go(Routes.mainLayout);
        break;
    }
  }

  /// Navigate to medical record screen
  static void _navigateToMedicalRecord(NotificationData data, GoRouter router) {
    debugPrint('Navigating to medical record');
    router.push(Routes.medicalRecordScreen);
  }

  /// Navigate to appointment management screen
  static void _navigateToAppointment(NotificationData data, GoRouter router) {
    debugPrint('Navigating to appointment management');
    router.push(Routes.appointmentManageScreen);
  }

  /// Navigate to diagnosis details
  static void _navigateToDiagnosis(NotificationData data, GoRouter router) {
    final diagnosisId = data.diagnosisId;
    final appointmentId = data.appointmentId;

    if (diagnosisId != null) {
      debugPrint('Navigating to diagnosis: $diagnosisId');
      // Navigate to diagnosis screen with recordId if available
      // You might need to fetch the record ID from the diagnosis ID
      router.push(Routes.medicalRecordScreen);
    } else if (appointmentId != null) {
      // If no diagnosis ID but appointment ID is available
      router.push(Routes.medicalRecordScreen);
    } else {
      // Fallback to medical records list
      router.push(Routes.medicalRecordScreen);
    }
  }

  /// Navigate to appointment details
  static void _navigateToAppointmentDetails(
    NotificationData data,
    GoRouter router,
  ) {
    final appointmentId = data.appointmentId;

    if (appointmentId != null) {
      debugPrint('Navigating to appointment details: $appointmentId');
      // Navigate to appointment details with query parameter
      router.pushNamed(
        Routes.appointmentDetails,
        queryParameters: {'appointmentId': appointmentId},
      );
    } else {
      // Fallback to appointment management screen
      router.push(Routes.appointmentManageScreen);
    }
  }

  /// Navigate to prescription details
  static void _navigateToPrescription(NotificationData data, GoRouter router) {
    final prescriptionId = data.prescriptionId;
    final appointmentId = data.appointmentId;

    if (prescriptionId != null || appointmentId != null) {
      debugPrint('Navigating to prescription: $prescriptionId');
      // Navigate to prescriptions screen with query parameters
      final queryParams = <String, String>{};
      if (prescriptionId != null) {
        queryParams['prescriptionId'] = prescriptionId;
      }
      if (appointmentId != null) queryParams['appointmentId'] = appointmentId;

      router.pushNamed(
        Routes.prescriptionsScreen,
        queryParameters: queryParams,
      );
    } else {
      // Fallback to medical records
      router.push(Routes.medicalRecordScreen);
    }
  }
}
