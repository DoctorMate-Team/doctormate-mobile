import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_body.g.dart';

@JsonSerializable()
class ResetPasswordRequestBody {
  final String email;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequestBody({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory ResetPasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}

/*
{
  "email": "dr.sssarah@example.com",
  "newPassword": "5zOrUwbxSvRwHV?J%cHdRB4EdtRYv04Hx55NB?q!N3oyztPogv%m&pJpj&1I74HmRF6Tb3okStgKJ22!WRg6%cuDrkKeXOnp5tJFET!WkCtB",
  "confirmPassword": "5zOrUwbxSvRwHV?J%cHdRB4EdtRYv04Hx55NB?q!N3oyztPogv%m&pJpj&1I74HmRF6Tb3okStgKJ22!WRg6%cuDrkKeXOnp5tJFET!WkCtB"
}
*/
