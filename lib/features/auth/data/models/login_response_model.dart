import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final String token;
  final User user;

  LoginResponseModel({required this.token, required this.user});
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class User {
  final String id;
  final String? fullName;
  final String email;
  final String role;
  final bool isVerified;
  final bool isCompletedProfile;

  User({
    required this.id,
    this.fullName,
    required this.email,
    required this.role,
    required this.isVerified,
    required this.isCompletedProfile,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
/*
{
    "code": 0,
    "message": "string",
    "data": {
        "token": "string",
        "user": {
            "id": "string",
            "fullName": null,
            "email": "string",
            "role": "string",
            "isVerified": true,
            "isCompletedProfile": true
        }
    }
}
*/