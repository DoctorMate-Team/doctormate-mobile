import 'package:json_annotation/json_annotation.dart';

part 'complete_profile_request_body.g.dart';

@JsonSerializable()
class CompleteProfileRequestBody {
  final String birthDate;
  final String gender;
  final String address;
  final String bloodType;

  CompleteProfileRequestBody({
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.bloodType,
  });

  factory CompleteProfileRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$CompleteProfileRequestBodyToJson(this);
}

/*
{
  "birthDate": "1990-01-01",
  "gender": "male",
  "address": "Cairo",
  "bloodType": "A+"
}
*/
