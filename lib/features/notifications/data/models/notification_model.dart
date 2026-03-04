import 'dart:convert';
import 'package:doctor_mate/core/models/notification_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final String? metadata;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.metadata,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  // Helper to get the notification type enum
  NotificationType get notificationType => NotificationType.fromString(type);

  // Helper to parse metadata as JSON
  Map<String, dynamic>? get metadataMap {
    if (metadata == null || metadata!.isEmpty) return null;
    try {
      return json.decode(metadata!) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Helper getters for common metadata fields
  String? get appointmentId => metadataMap?['appointmentId'];
  String? get prescriptionId => metadataMap?['prescriptionId'];
  String? get diagnosisId => metadataMap?['diagnosisId'];
  String? get doctorName => metadataMap?['doctorName'];
  String? get scheduledStart => metadataMap?['scheduledStart'];
  int? get medicationCount => metadataMap?['medicationCount'];
}
