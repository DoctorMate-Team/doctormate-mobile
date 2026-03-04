// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceTokenRegisterRequest _$DeviceTokenRegisterRequestFromJson(
  Map<String, dynamic> json,
) => DeviceTokenRegisterRequest(
  token: json['token'] as String,
  deviceType: json['deviceType'] as String,
  deviceName: json['deviceName'] as String,
);

Map<String, dynamic> _$DeviceTokenRegisterRequestToJson(
  DeviceTokenRegisterRequest instance,
) => <String, dynamic>{
  'token': instance.token,
  'deviceType': instance.deviceType,
  'deviceName': instance.deviceName,
};

DeviceTokenUnregisterRequest _$DeviceTokenUnregisterRequestFromJson(
  Map<String, dynamic> json,
) => DeviceTokenUnregisterRequest(token: json['token'] as String);

Map<String, dynamic> _$DeviceTokenUnregisterRequestToJson(
  DeviceTokenUnregisterRequest instance,
) => <String, dynamic>{'token': instance.token};
