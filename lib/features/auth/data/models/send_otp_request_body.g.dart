// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpRequestBody _$SendOtpRequestBodyFromJson(Map<String, dynamic> json) =>
    SendOtpRequestBody(
      email: json['email'] as String,
      isForgetPass: json['isForgetPass'] as bool,
    );

Map<String, dynamic> _$SendOtpRequestBodyToJson(SendOtpRequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'isForgetPass': instance.isForgetPass,
    };
