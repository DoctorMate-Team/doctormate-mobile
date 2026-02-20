// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunicationSessionResponse _$CommunicationSessionResponseFromJson(
  Map<String, dynamic> json,
) => CommunicationSessionResponse(
  sessionId: json['sessionId'] as String,
  appointmentId: json['appointmentId'] as String,
  type: json['type'] as String,
  status: json['status'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  startedAt: DateTime.parse(json['startedAt'] as String),
);

Map<String, dynamic> _$CommunicationSessionResponseToJson(
  CommunicationSessionResponse instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'appointmentId': instance.appointmentId,
  'type': instance.type,
  'status': instance.status,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'startedAt': instance.startedAt.toIso8601String(),
};
