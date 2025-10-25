import 'package:json_annotation/json_annotation.dart';

part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  final String email;
  final String phoneNumber;
  final String password;
  final String role;
  final String fullName;

  RegisterRequestBody({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.role,
    required this.fullName,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}

/*
{
  "email": "dr.sssarah@example.com",
  "phoneNumber": "01098765432",
  "password": "DoctorPass123!",
  "role": "Doctor",
  "fullName": "Dr. Sarah Ahmed"
}
*/
