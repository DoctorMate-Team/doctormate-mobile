import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request_body.g.dart';

@JsonSerializable()
class VerifyOtpRequestBody {
  final String email;
  final String otpCode;
  final bool isForgetPass;

  VerifyOtpRequestBody({
    required this.email,
    required this.otpCode,
    required this.isForgetPass,
  });

  factory VerifyOtpRequestBody.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestBodyToJson(this);
}

/*
{
  "email": "test@gmail.com",
  "otpCode": "031068",
  "isForgetPass": true
}
*/
