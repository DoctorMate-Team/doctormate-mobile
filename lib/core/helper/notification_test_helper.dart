import 'package:doctor_mate/core/services/local_notification_service.dart';
import 'package:doctor_mate/core/models/notification_data.dart';
import 'package:doctor_mate/core/models/notification_type.dart';
import 'package:flutter/material.dart';

/// Helper class for testing and debugging notifications
class NotificationTestHelper {
  static final LocalNotificationService _notificationService =
      LocalNotificationService();

  /// Show a test diagnosis notification
  static Future<void> showTestDiagnosisNotification() async {
    final notifId = LocalNotificationService.generateNotificationId();
    final data = NotificationData(
      notificationId: 'test-diagnosis-$notifId',
      type: NotificationType.diagnosisAdded,
      clickAction: NotificationClickAction.openMedicalRecord,
      metadata: {
        'diagnosisId': '945fa7a5-73c2-48e3-abdd-d6948a17a7c9',
        'doctorName': 'Dr. Mohamed',
        'appointmentId': '693bf3db-e67e-476f-b078-06e9678a2c21',
      },
    );

    final content = _notificationService.getNotificationContent(data);

    await _notificationService.showNotification(
      id: notifId,
      title: content['title']!,
      body: content['body']!,
      data: data,
      channelId: 'medical_records',
      channelName: 'Medical Records',
    );
  }

  /// Show a test appointment reminder notification
  static Future<void> showTestAppointmentReminderNotification() async {
    final scheduledTime = DateTime.now().add(const Duration(hours: 2));
    final notifId = LocalNotificationService.generateNotificationId();

    final data = NotificationData(
      notificationId: 'test-appointment-$notifId',
      type: NotificationType.appointmentReminder,
      clickAction: NotificationClickAction.none,
      metadata: {
        'appointmentId': 'c8f0d20e-49c4-4113-8d4b-1f55fccc6af9',
        'patientName': 'Test User',
        'scheduledStart': scheduledTime.toIso8601String(),
      },
    );

    final content = _notificationService.getNotificationContent(data);

    await _notificationService.showNotification(
      id: notifId,
      title: content['title']!,
      body: content['body']!,
      data: data,
      channelId: 'appointments',
      channelName: 'Appointments',
    );
  }

  /// Show a test appointment confirmed notification
  static Future<void> showTestAppointmentConfirmedNotification() async {
    final notifId = LocalNotificationService.generateNotificationId();
    final data = NotificationData(
      notificationId: 'test-confirmed-$notifId',
      type: NotificationType.appointmentConfirmed,
      clickAction: NotificationClickAction.none,
      metadata: {
        'appointmentId': 'b5b2c876-1a43-4ac4-ada2-93b505057ddf',
        'doctorName': 'Dr. Mohamed',
        'scheduledStart':
            DateTime.now().add(const Duration(days: 1)).toIso8601String(),
      },
    );

    final content = _notificationService.getNotificationContent(data);

    await _notificationService.showNotification(
      id: notifId,
      title: content['title']!,
      body: content['body']!,
      data: data,
      channelId: 'appointments',
      channelName: 'Appointments',
    );
  }

  /// Show a test prescription notification
  static Future<void> showTestPrescriptionNotification() async {
    final notifId = LocalNotificationService.generateNotificationId();
    final data = NotificationData(
      notificationId: 'test-prescription-$notifId',
      type: NotificationType.prescriptionCreated,
      clickAction: NotificationClickAction.openMedicalRecord,
      metadata: {
        'prescriptionId': 'cd54e30d-e8be-44b1-9bfd-73babcdb51f0',
        'doctorName': 'Dr. Mohamed',
        'medicationCount': 3,
        'appointmentId': '693bf3db-e67e-476f-b078-06e9678a2c21',
      },
    );

    final content = _notificationService.getNotificationContent(data);

    await _notificationService.showNotification(
      id: notifId,
      title: content['title']!,
      body: content['body']!,
      data: data,
      channelId: 'prescriptions',
      channelName: 'Prescriptions',
    );
  }

  /// Show all test notifications
  static Future<void> showAllTestNotifications() async {
    await showTestDiagnosisNotification();
    await Future.delayed(const Duration(seconds: 1));

    await showTestAppointmentReminderNotification();
    await Future.delayed(const Duration(seconds: 1));

    await showTestAppointmentConfirmedNotification();
    await Future.delayed(const Duration(seconds: 1));

    await showTestPrescriptionNotification();
  }
}

/// Debug screen for testing notifications
class NotificationTestScreen extends StatelessWidget {
  const NotificationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Testing')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Test Notifications',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed:
                () => NotificationTestHelper.showTestDiagnosisNotification(),
            icon: const Icon(Icons.medical_information),
            label: const Text('Test Diagnosis Notification'),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed:
                () =>
                    NotificationTestHelper.showTestAppointmentReminderNotification(),
            icon: const Icon(Icons.alarm),
            label: const Text('Test Appointment Reminder'),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed:
                () =>
                    NotificationTestHelper.showTestAppointmentConfirmedNotification(),
            icon: const Icon(Icons.check_circle),
            label: const Text('Test Appointment Confirmed'),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed:
                () => NotificationTestHelper.showTestPrescriptionNotification(),
            icon: const Icon(Icons.medication),
            label: const Text('Test Prescription Notification'),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => NotificationTestHelper.showAllTestNotifications(),
            icon: const Icon(Icons.all_inclusive),
            label: const Text('Show All Test Notifications'),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
          ),
          const SizedBox(height: 24),
          const Text(
            'Instructions:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '1. Tap any button to show a test notification\n'
            '2. Tap the notification to test navigation\n'
            '3. Check debug console for logs\n'
            '4. Test in different app states (foreground, background, terminated)',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
