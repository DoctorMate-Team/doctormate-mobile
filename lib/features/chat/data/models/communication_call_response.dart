import 'package:json_annotation/json_annotation.dart';

part 'communication_call_response.g.dart';
@JsonSerializable()
class CommunicationCallResponse {
  final String provider;
  final String channel;
  final String token;
  final DateTime expiresAt;

  CommunicationCallResponse({
    required this.provider,
    required this.channel,
    required this.token,
    required this.expiresAt,
  });

  factory CommunicationCallResponse.fromJson(Map<String, dynamic> json) =>
      _$CommunicationCallResponseFromJson(json);
}

/*
{
    "provider": "agora",
    "channel": "call_{appointment-2-id-no-hyphens}",
    "token": "007...(base64 Agora token)...",
    "expiresAt": "2025-01-28T10:45:00Z"
  }

*/