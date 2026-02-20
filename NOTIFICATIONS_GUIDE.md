# Firebase Cloud Messaging (FCM) with Flutter Local Notifications

This document explains the FCM notification system implementation in the DoctorMate app.

## 📋 Overview

The notification system handles push notifications from Firebase Cloud Messaging and displays them using Flutter Local Notifications. It supports different notification types with custom navigation handling.

## 🏗️ Architecture

### Core Components

1. **FirebaseMessagingService** (`lib/core/services/firebase_messaging_service.dart`)
   - Main service for handling FCM
   - Manages foreground, background, and terminated state notifications
   - Integrates with LocalNotificationService

2. **LocalNotificationService** (`lib/core/services/local_notification_service.dart`)
   - Handles local notification display
   - Creates notification channels for Android
   - Manages notification tap callbacks

3. **NotificationData Model** (`lib/core/models/notification_data.dart`)
   - Parses FCM message data
   - Provides helper methods for metadata access

4. **NotificationType & NotificationClickAction** (`lib/core/models/notification_type.dart`)
   - Enums for notification types and actions
   - Type-safe handling of notification categories

5. **NotificationNavigationHandler** (`lib/core/services/notification_navigation_handler.dart`)
   - Handles navigation based on notification type
   - Routes to appropriate screens with parameters

## 📱 Supported Notification Types

### 1. DiagnosisAdded
```json
{
  "type": "DiagnosisAdded",
  "click_action": "OPEN_MEDICAL_RECORD",
  "notificationId": "uuid",
  "metadata": {
    "diagnosisId": "uuid",
    "doctorName": "Mohamed",
    "appointmentId": "uuid"
  }
}
```
**Navigation**: Medical Record Screen → Diagnosis Details

### 2. AppointmentReminder
```json
{
  "type": "AppointmentReminder",
  "click_action": "",
  "notificationId": "uuid",
  "metadata": {
    "appointmentId": "uuid",
    "patientName": "John Doe",
    "scheduledStart": "2026-02-11T14:45:00"
  }
}
```
**Navigation**: Appointment Management Screen

### 3. AppointmentConfirmed
```json
{
  "type": "AppointmentConfirmed",
  "click_action": "",
  "notificationId": "uuid",
  "metadata": {
    "appointmentId": "uuid",
    "doctorName": "Mohamed",
    "scheduledStart": "2025-12-10T09:45:00"
  }
}
```
**Navigation**: Appointment Management Screen

### 4. PrescriptionCreated
```json
{
  "type": "PrescriptionCreated",
  "click_action": "OPEN_MEDICAL_RECORD",
  "notificationId": "uuid",
  "metadata": {
    "prescriptionId": "uuid",
    "doctorName": "Mohamed",
    "medicationCount": 3
  }
}
```
**Navigation**: Prescriptions Screen with prescriptionId

## 🔔 Notification Channels (Android)

The app creates the following notification channels:

| Channel ID | Name | Importance | Description |
|------------|------|------------|-------------|
| `appointments` | Appointments | High | Appointment reminders and confirmations |
| `medical_records` | Medical Records | High | Diagnoses and medical record updates |
| `prescriptions` | Prescriptions | High | New prescriptions |
| `general` | General | Default | General notifications |

## 🚀 Usage

### Initialization

The notification services are initialized in `main.dart`:

```dart
void main() async {
  // ... other initializations

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Initialize Firebase Messaging
  final firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.initialize();
  
  // Set the router for navigation from notifications
  firebaseMessagingService.setRouter(AppRouter.router);

  // ... run app
}
```

### Handling Notifications in Different States

#### 1. Foreground (App is open)
- FCM message received
- Parsed to NotificationData
- Local notification displayed automatically
- Tap opens relevant screen

#### 2. Background (App is in background)
- System notification displayed
- Tap triggers `onMessageOpenedApp` listener
- Navigation handled by FirebaseMessagingService

#### 3. Terminated (App is closed)
- System notification displayed
- Tap launches app
- `getInitialMessage()` retrieves notification data
- Navigation performed after app initialization

### Sending Notifications from Backend

#### FCM Data Message Format

```json
{
  "to": "FCM_TOKEN",
  "data": {
    "type": "DiagnosisAdded",
    "click_action": "OPEN_MEDICAL_RECORD",
    "notificationId": "9599c4e3-1d8a-4973-bcc0-24620b6e94cd",
    "metadata": "{\"diagnosisId\":\"945fa7a5-73c2-48e3-abdd-d6948a17a7c9\",\"doctorName\":\"Mohamed\",\"appointmentId\":\"693bf3db-e67e-476f-b078-06e9678a2c21\"}"
  }
}
```

**Note**: The `metadata` can be either:
- A JSON string (will be parsed)
- A JSON object (used directly)

#### Using FCM HTTP v1 API

```json
{
  "message": {
    "token": "FCM_TOKEN",
    "data": {
      "type": "PrescriptionCreated",
      "click_action": "OPEN_MEDICAL_RECORD",
      "notificationId": "04b5304d-d613-4bfd-8d74-b587c2d4c8e1",
      "metadata": "{\"prescriptionId\":\"cd54e30d-e8be-44b1-9bfd-73babcdb51f0\",\"doctorName\":\"Mohamed\",\"medicationCount\":\"3\"}"
    },
    "android": {
      "priority": "high"
    },
    "apns": {
      "headers": {
        "apns-priority": "10"
      }
    }
  }
}
```

## 🔧 Configuration

### Android Configuration

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <application>
        <!-- ... -->
        
        <!-- FCM Default Icon -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_icon"
            android:resource="@mipmap/ic_launcher" />
            
        <!-- FCM Default Color -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_color"
            android:resource="@color/colorPrimary" />
            
        <!-- FCM Default Channel -->
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_channel_id"
            android:value="default_channel" />
    </application>
</manifest>
```

### iOS Configuration

1. Enable Push Notifications capability in Xcode
2. Upload APNs certificate/key to Firebase Console
3. Add to `ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

## 📦 Dependencies

```yaml
dependencies:
  firebase_core: ^3.8.1
  firebase_messaging: ^15.1.5
  flutter_local_notifications: ^18.0.1
```

## 🧪 Testing

### Get FCM Token

The token is printed in debug console on app launch. Use it to send test notifications.

### Test Notification via Firebase Console

1. Go to Firebase Console → Cloud Messaging
2. Click "Send your first message"
3. Enter notification title and text
4. Select target app
5. Under "Additional options" → "Custom data", add:
   - Key: `type`, Value: `DiagnosisAdded`
   - Key: `click_action`, Value: `OPEN_MEDICAL_RECORD`
   - Key: `metadata`, Value: JSON string

### Test via cURL

```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: Bearer YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "FCM_TOKEN",
    "data": {
      "type": "AppointmentReminder",
      "notificationId": "test-123",
      "metadata": "{\"appointmentId\":\"test-appt\",\"patientName\":\"Test User\",\"scheduledStart\":\"2026-02-20T10:00:00\"}"
    }
  }'
```

## 🔍 Debugging

Enable verbose logging:

```dart
// In FirebaseMessagingService
debugPrint('FCM Token: $token');
debugPrint('Notification data: ${message.data}');
debugPrint('Parsed notification: ${notificationData.toString()}');
```

Check logcat (Android):
```bash
adb logcat | grep FCM
```

Check Console (iOS):
- Open Xcode Console while device is connected
- Filter by "FCM" or "notification"

## 📝 Best Practices

1. **Always send data messages** (not notification messages) for custom handling
2. **Keep metadata small** - FCM has a 4KB payload limit
3. **Handle missing data gracefully** - Check for null values
4. **Test all app states** - Foreground, background, and terminated
5. **Update FCM token** - Listen to `onTokenRefresh` and update backend
6. **Respect user preferences** - Check notification permissions before showing

## 🐛 Common Issues

### Notifications not showing on Android
- Check notification channels are created
- Verify app has notification permissions
- Test with `flutter_local_notifications` directly

### Navigation not working
- Ensure router is set on FirebaseMessagingService
- Check route names match in Routes class
- Verify metadata contains required IDs

### Background handler not called
- Ensure handler is top-level function
- Check `@pragma('vm:entry-point')` annotation
- Verify background handler is registered before runApp()

### iOS notifications not working
- Check APNs certificate is uploaded to Firebase
- Verify Push Notifications capability is enabled
- Test on real device (not simulator for push notifications)

## 🔐 Security Considerations

1. **Validate notification data** - Never trust client input
2. **Authenticate API calls** - Use FCM token securely
3. **Limit sensitive data** - Don't send passwords or tokens in notifications
4. **Verify notification source** - Implement server-side verification

## 📚 References

- [Firebase Cloud Messaging Docs](https://firebase.google.com/docs/cloud-messaging)
- [flutter_local_notifications Package](https://pub.dev/packages/flutter_local_notifications)
- [FCM HTTP v1 API](https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages)
