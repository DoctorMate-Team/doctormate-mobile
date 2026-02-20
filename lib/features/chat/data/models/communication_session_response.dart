import 'package:json_annotation/json_annotation.dart';

part 'communication_session_response.g.dart';
@JsonSerializable()
class CommunicationSessionResponse {
  final String sessionId;
  final String appointmentId;
  final String type;
  final String status;
  final DateTime expiresAt;
  final DateTime startedAt;

  CommunicationSessionResponse({
    required this.sessionId,
    required this.appointmentId,
    required this.type,
    required this.status,
    required this.expiresAt,
    required this.startedAt,
  });

  factory CommunicationSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$CommunicationSessionResponseFromJson(json);
}

/*
{
    "sessionId": "new-session-guid",
    "appointmentId": "{appointment-2-id}",
    "type": "chat",
    "status": "active",
    "expiresAt": "2025-01-28T10:45:00Z",
    "startedAt": "2025-01-28T09:55:00Z"
  }
*/