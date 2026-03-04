import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  final String token;
  final User user;

  RegisterResponseModel({required this.token, required this.user});
  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
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