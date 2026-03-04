import 'package:json_annotation/json_annotation.dart';

part 'device_token_request.g.dart';

@JsonSerializable()
class DeviceTokenRegisterRequest {
  final String token;
  final String deviceType;
  final String deviceName;

  DeviceTokenRegisterRequest({
    required this.token,
    required this.deviceType,
    required this.deviceName,
  });

  factory DeviceTokenRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokenRegisterRequestToJson(this);
}

@JsonSerializable()
class DeviceTokenUnregisterRequest {
  final String token;

  DeviceTokenUnregisterRequest({required this.token});

  factory DeviceTokenUnregisterRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenUnregisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTokenUnregisterRequestToJson(this);
}
