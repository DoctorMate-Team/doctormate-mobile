import 'dart:io';

import 'package:doctor_mate/core/models/notification_data.dart';
import 'package:doctor_mate/core/models/notification_type.dart';
import 'package:doctor_mate/core/networking/device_token_repository.dart';
import 'package:doctor_mate/core/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

/// Background message handler
/// Must be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  debugPrint('Message data: ${message.data}');
  debugPrint('Message notification: ${message.notification?.title}');

  // Parse notification data
  if (message.data.isNotEmpty) {
    try {
      final notificationData = NotificationData.fromMap(message.data);
      final localNotificationService = LocalNotificationService();

      // Get notification content
      final content = localNotificationService.getNotificationContent(
        notificationData,
      );

      // Show local notification
      await localNotificationService.showNotification(
        id: message.hashCode,
        title: content['title'] ?? 'DoctorMate',
        body: content['body'] ?? 'You have a new notification',
        data: notificationData,
      );
    } catch (e) {
      debugPrint('Error handling background notification: $e');
    }
  }
}

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final LocalNotificationService _localNotificationService =
      LocalNotificationService();
  final DeviceTokenRepository? _deviceTokenRepository;

  // Router for navigation
  GoRouter? _router;

  // Store current token
  String? _currentToken;

  FirebaseMessagingService({DeviceTokenRepository? deviceTokenRepository})
    : _deviceTokenRepository = deviceTokenRepository;

  /// Set the router for navigation handling
  void setRouter(GoRouter router) {
    _router = router;
  }

  /// Initialize Firebase Messaging
  Future<void> initialize() async {
    // Request permission for iOS
    await requestPermission();

    // Initialize local notifications
    await _localNotificationService.initialize(
      onNotificationTapped: _handleNotificationTap,
    );

    // Create notification channels for Android
    await _createNotificationChannels();

    // Get FCM token
    final token = await getFCMToken();
    debugPrint('FCM Token: $token');

    // Register device token with backend
    if (token != null) {
      await _registerDeviceToken(token);
    }

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(
      _handleBackgroundNotificationTap,
    );

    // Check if app was opened from a terminated state via notification
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundNotificationTap(initialMessage);
    }

    // Listen to token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      debugPrint('FCM Token refreshed: $newToken');
      _registerDeviceToken(newToken);
    });
  }

  /// Request notification permission (especially for iOS)
  Future<void> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  /// Get FCM token
  Future<String?> getFCMToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Received foreground message: ${message.messageId}');
    debugPrint('Message data: ${message.data}');

    if (message.data.isNotEmpty) {
      try {
        // Parse notification data
        final notificationData = NotificationData.fromMap(message.data);
        debugPrint('Parsed notification: ${notificationData.toString()}');

        // Get notification content
        final content = _localNotificationService.getNotificationContent(
          notificationData,
        );

        // Show local notification
        _localNotificationService.showNotification(
          id: message.hashCode,
          title: content['title'] ?? 'DoctorMate',
          body: content['body'] ?? 'You have a new notification',
          data: notificationData,
        );
      } catch (e) {
        debugPrint('Error handling foreground notification: $e');

        // Fallback to default notification if available
        if (message.notification != null) {
          _localNotificationService.showNotification(
            id: message.hashCode,
            title: message.notification!.title ?? 'DoctorMate',
            body: message.notification!.body ?? 'You have a new notification',
          );
        }
      }
    } else if (message.notification != null) {
      // Show notification from FCM notification payload
      _localNotificationService.showNotification(
        id: message.hashCode,
        title: message.notification!.title ?? 'DoctorMate',
        body: message.notification!.body ?? 'You have a new notification',
      );
    }
  }

  /// Handle notification tap when app is in background
  void _handleBackgroundNotificationTap(RemoteMessage message) {
    debugPrint('Notification tapped: ${message.messageId}');
    debugPrint('Message data: ${message.data}');

    if (message.data.isNotEmpty) {
      try {
        final notificationData = NotificationData.fromMap(message.data);
        _handleNotificationTap(notificationData);
      } catch (e) {
        debugPrint('Error handling notification tap: $e');
      }
    }
  }

  /// Handle notification tap (both local and FCM)
  void _handleNotificationTap(NotificationData data) {
    debugPrint('Handling notification tap: ${data.type.value}');

    if (_router != null) {
      // Import the navigation handler
      void NotificationNavigationHandler() {
        // Inline navigation logic
        _navigateBasedOnNotification(data);
      }
      NotificationNavigationHandler();
    } else {
      debugPrint('Router not set. Cannot navigate.');
    }
  }

  /// Navigate based on notification data
  void _navigateBasedOnNotification(NotificationData data) {
    // Handle based on click action first
    if (data.clickAction == NotificationClickAction.openMedicalRecord) {
      _router?.push('/medicalRecordScreen');
      return;
    }

    if (data.clickAction == NotificationClickAction.openAppointment) {
      _router?.push('/appointmentManageScreen');
      return;
    }

    if (data.clickAction == NotificationClickAction.openAppointmentDetails) {
      if (data.appointmentId != null) {
        debugPrint('Navigating to appointment details: ${data.appointmentId}');
        _router?.pushNamed(
          '/appointmentDetails',
          queryParameters: {'appointmentId': data.appointmentId!},
        );
      } else {
        _router?.push('/appointmentManageScreen');
      }
      return;
    }

    // Handle based on notification type
    switch (data.type) {
      case NotificationType.diagnosisAdded:
        _router?.push('/medicalRecordScreen');
        break;

      case NotificationType.appointmentReminder:
      case NotificationType.appointmentConfirmed:
      case NotificationType.appointmentCancelled:
        if (data.appointmentId != null) {
          _router?.pushNamed(
            '/appointmentDetails',
            queryParameters: {'appointmentId': data.appointmentId!},
          );
        } else {
          _router?.push('/appointmentManageScreen');
        }
        break;

      case NotificationType.prescriptionCreated:
        if (data.prescriptionId != null || data.appointmentId != null) {
          final queryParams = <String, String>{};
          if (data.prescriptionId != null) {
            queryParams['prescriptionId'] = data.prescriptionId!;
          }
          if (data.appointmentId != null) {
            queryParams['appointmentId'] = data.appointmentId!;
          }
          _router?.pushNamed(
            '/prescriptionsScreen',
            queryParameters: queryParams,
          );
        } else {
          _router?.push('/medicalRecordScreen');
        }
        break;

      case NotificationType.unknown:
        _router?.go('/mainLayout');
        break;
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }

  /// Delete FCM token
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      debugPrint('FCM token deleted');
    } catch (e) {
      debugPrint('Error deleting FCM token: $e');
    }
  }

  /// Create notification channels for Android
  Future<void> _createNotificationChannels() async {
    await _localNotificationService.createNotificationChannel(
      channelId: 'appointments',
      channelName: 'Appointments',
      channelDescription: 'Notifications about appointments',
      importance: Importance.high,
    );

    await _localNotificationService.createNotificationChannel(
      channelId: 'medical_records',
      channelName: 'Medical Records',
      channelDescription: 'Notifications about medical records and diagnoses',
      importance: Importance.high,
    );

    await _localNotificationService.createNotificationChannel(
      channelId: 'prescriptions',
      channelName: 'Prescriptions',
      channelDescription: 'Notifications about prescriptions',
      importance: Importance.high,
    );

    await _localNotificationService.createNotificationChannel(
      channelId: 'general',
      channelName: 'General',
      channelDescription: 'General notifications',
      importance: Importance.defaultImportance,
    );
  }

  /// Register device token with backend
  Future<void> _registerDeviceToken(String token) async {
    if (_deviceTokenRepository == null) {
      debugPrint('DeviceTokenRepository not available');
      return;
    }

    try {
      _currentToken = token;
      final deviceType = Platform.isAndroid ? 'android' : 'ios';
      final deviceName = Platform.isAndroid ? 'Android Device' : 'iOS Device';

      final result = await _deviceTokenRepository.registerDeviceToken(
        token: token,
        deviceType: deviceType,
        deviceName: deviceName,
      );

      result.when(
        success: (_) {
          debugPrint('Device token registered successfully');
        },
        failure: (error) {
          debugPrint(
            'Error registering device token: ${error.apiErrorModel.message}',
          );
        },
      );
    } catch (e) {
      debugPrint('Exception registering device token: $e');
    }
  }

  /// Unregister device token from backend
  Future<void> unregisterDeviceToken() async {
    if (_deviceTokenRepository == null) {
      debugPrint('DeviceTokenRepository not available');
      return;
    }

    if (_currentToken == null) {
      debugPrint('No token to unregister');
      return;
    }

    try {
      final result = await _deviceTokenRepository.unregisterDeviceToken(
        token: _currentToken!,
      );

      result.when(
        success: (_) {
          debugPrint('Device token unregistered successfully');
          _currentToken = null;
        },
        failure: (error) {
          debugPrint(
            'Error unregistering device token: ${error.apiErrorModel.message}',
          );
        },
      );

      // Also delete the FCM token
      await deleteToken();
    } catch (e) {
      debugPrint('Exception unregistering device token: $e');
    }
  }
}
