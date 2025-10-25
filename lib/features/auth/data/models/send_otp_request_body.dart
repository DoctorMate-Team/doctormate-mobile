import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request_body.g.dart';

@JsonSerializable()
class SendOtpRequestBody {
  final String email;
  final bool isForgetPass;
  const SendOtpRequestBody({required this.email, required this.isForgetPass});

  Map<String, dynamic> toJson() => _$SendOtpRequestBodyToJson(this);
}
/*
{
  "email": "test@gmail.com",
  "isForgetPass": true
}

*/