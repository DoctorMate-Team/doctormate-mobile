import 'dart:convert';
import 'package:doctor_mate/core/models/notification_type.dart';

class NotificationData {
  final String? notificationId;
  final NotificationType type;
  final NotificationClickAction clickAction;
  final Map<String, dynamic> metadata;

  NotificationData({
    this.notificationId,
    required this.type,
    required this.clickAction,
    required this.metadata,
  });

  factory NotificationData.fromMap(Map<String, dynamic> data) {
    // Parse metadata if it's a string
    Map<String, dynamic> parsedMetadata = {};
    if (data['metadata'] != null) {
      if (data['metadata'] is String) {
        try {
          parsedMetadata = jsonDecode(data['metadata']);
        } catch (e) {
          parsedMetadata = {};
        }
      } else if (data['metadata'] is Map) {
        parsedMetadata = Map<String, dynamic>.from(data['metadata']);
      }
    }

    return NotificationData(
      notificationId: data['notificationId'] as String?,
      type: NotificationType.fromString(data['type'] as String?),
      clickAction: NotificationClickAction.fromString(
        data['click_action'] as String?,
      ),
      metadata: parsedMetadata,
    );
  }

  // Diagnosis metadata helpers
  String? get diagnosisId => metadata['diagnosisId'] as String?;
  String? get doctorName => metadata['doctorName'] as String?;

  // Appointment metadata helpers
  String? get appointmentId => metadata['appointmentId'] as String?;
  String? get patientName => metadata['patientName'] as String?;
  String? get scheduledStart => metadata['scheduledStart'] as String?;

  // Prescription metadata helpers
  String? get prescriptionId => metadata['prescriptionId'] as String?;
  int? get medicationCount => metadata['medicationCount'] as int?;

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'type': type.value,
      'click_action': clickAction.value,
      'metadata': metadata,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(jsonDecode(source));

  @override
  String toString() {
    return 'NotificationData(notificationId: $notificationId, type: ${type.value}, clickAction: ${clickAction.value}, metadata: $metadata)';
  }
}
