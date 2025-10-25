import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  final String id;
  final String email;
  final String role;

  RegisterResponseModel({
    required this.id,
    required this.email,
    required this.role,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}

/*
{
    "code": 0,
    "message": "string",
    "data": {
        "id": "string",
        "email": "string",
        "role": "string"
    }
}
*/
