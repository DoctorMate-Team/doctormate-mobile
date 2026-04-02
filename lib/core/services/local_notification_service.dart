import 'package:doctor_mate/core/models/notification_data.dart';
import 'package:doctor_mate/core/models/notification_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Callback for when notification is tapped
  Function(NotificationData)? onNotificationTap;

  /// Generate a valid notification ID that fits in 32-bit integer range
  static int generateNotificationId() {
    // Use current time in seconds and modulo to keep it within 32-bit range
    // This gives us a unique ID that resets every ~24 days but avoids collisions
    return DateTime.now().millisecondsSinceEpoch % 2147483647;
  }

  /// Initialize local notifications
  Future<void> initialize({
    Function(NotificationData)? onNotificationTapped,
  }) async {
    onNotificationTap = onNotificationTapped;

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onNotificationResponse,
    );

    debugPrint('Local notifications initialized');
  }

  /// Handle notification tap response
  @pragma('vm:entry-point')
  static void _onNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) {
      try {
        final notificationData = NotificationData.fromJson(payload);
        debugPrint('Notification tapped: ${notificationData.toString()}');

        // Call the callback if set
        LocalNotificationService().onNotificationTap?.call(notificationData);
      } catch (e) {
        debugPrint('Error parsing notification payload: $e');
      }
    }
  }

  /// Show a notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    NotificationData? data,
    String? channelId,
    String? channelName,
  }) async {
    try {
      final androidDetails = AndroidNotificationDetails(
        channelId ?? 'default_channel',
        channelName ?? 'Default Notifications',
        channelDescription: 'General notifications from DoctorMate',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notificationsPlugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: notificationDetails,
        payload: data?.toJson(),
      );

      debugPrint('Notification shown: $title');
    } catch (e) {
      debugPrint('Error showing notification: $e');
    }
  }

  /// Request notification permissions (iOS)
  Future<bool> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final result = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return result ?? false;
    }
    return true;
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  /// Create notification channel (Android 8.0+)
  Future<void> createNotificationChannel({
    required String channelId,
    required String channelName,
    String? channelDescription,
    Importance importance = Importance.high,
  }) async {
    final androidPlugin =
        _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidPlugin != null) {
      final channel = AndroidNotificationChannel(
        channelId,
        channelName,
        description: channelDescription,
        importance: importance,
      );

      await androidPlugin.createNotificationChannel(channel);
      debugPrint('Notification channel created: $channelName');
    }
  }

  /// Get notification title and body based on type
  Map<String, String> getNotificationContent(NotificationData data) {
    String title = '';
    String body = '';

    switch (data.type) {
      case NotificationType.diagnosisAdded:
        title = '📋 New Diagnosis Available';
        body =
            data.doctorName != null
                ? 'Dr. ${data.doctorName} has added a diagnosis to your medical record'
                : 'A new diagnosis has been added to your medical record';
        break;

      case NotificationType.appointmentReminder:
        title = '⏰ Appointment Reminder';
        if (data.patientName != null && data.scheduledStart != null) {
          final date = DateTime.tryParse(data.scheduledStart!);
          final formattedDate =
              date != null
                  ? '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}'
                  : data.scheduledStart;
          body = 'Your appointment is scheduled for $formattedDate';
        } else {
          body = 'You have an upcoming appointment';
        }
        break;

      case NotificationType.appointmentConfirmed:
        title = '✅ Appointment Confirmed';
        if (data.doctorName != null) {
          body =
              'Your appointment with Dr. ${data.doctorName} has been confirmed';
        } else {
          body = 'Your appointment has been confirmed';
        }
        break;

      case NotificationType.appointmentCancelled:
        title = '❌ Appointment Cancelled';
        if (data.doctorName != null) {
          body =
              'Your appointment with Dr. ${data.doctorName} has been cancelled';
        } else {
          body = 'Your appointment has been cancelled';
        }
        break;

      case NotificationType.appointmentExpired:
        title = '⏳ Appointment Expired';
        if (data.doctorName != null) {
          body = 'Your appointment with Dr. ${data.doctorName} has expired';
        } else {
          body = 'Your appointment has expired';
        }
        break;

      case NotificationType.paymentSuccess:
        title = '💰 Payment Successful';
        if (data.amount != null && data.currency != null) {
          body =
              'Your payment of ${data.amount} ${data.currency} was successful';
        } else {
          body = 'Your payment was successful';
        }
        break;

      case NotificationType.prescriptionCreated:
        title = '💊 New Prescription';
        if (data.doctorName != null && data.medicationCount != null) {
          body =
              'Dr. ${data.doctorName} prescribed ${data.medicationCount} medication(s)';
        } else if (data.doctorName != null) {
          body = 'Dr. ${data.doctorName} has created a new prescription';
        } else {
          body = 'A new prescription has been created';
        }
        break;

      case NotificationType.unknown:
        title = '🔔 DoctorMate Notification';
        body = 'You have a new notification';
        break;
    }

    return {'title': title, 'body': body};
  }
}
