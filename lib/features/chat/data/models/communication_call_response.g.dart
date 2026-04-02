// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_call_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunicationCallResponse _$CommunicationCallResponseFromJson(
  Map<String, dynamic> json,
) => CommunicationCallResponse(
  provider: json['provider'] as String,
  channel: json['channel'] as String,
  token: json['token'] as String,
  callType: json['callType'] as String?,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$CommunicationCallResponseToJson(
  CommunicationCallResponse instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'channel': instance.channel,
  'token': instance.token,
  'callType': instance.callType,
  'expiresAt': instance.expiresAt.toIso8601String(),
};
