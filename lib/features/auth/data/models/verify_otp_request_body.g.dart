// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpRequestBody _$VerifyOtpRequestBodyFromJson(
  Map<String, dynamic> json,
) => VerifyOtpRequestBody(
  email: json['email'] as String,
  otpCode: json['otpCode'] as String,
  isForgetPass: json['isForgetPass'] as bool,
);

Map<String, dynamic> _$VerifyOtpRequestBodyToJson(
  VerifyOtpRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'otpCode': instance.otpCode,
  'isForgetPass': instance.isForgetPass,
};
