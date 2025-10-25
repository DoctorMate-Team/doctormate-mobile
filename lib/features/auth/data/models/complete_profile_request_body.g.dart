// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteProfileRequestBody _$CompleteProfileRequestBodyFromJson(
  Map<String, dynamic> json,
) => CompleteProfileRequestBody(
  birthDate: json['birthDate'] as String,
  gender: json['gender'] as String,
  address: json['address'] as String,
  bloodType: json['bloodType'] as String,
);

Map<String, dynamic> _$CompleteProfileRequestBodyToJson(
  CompleteProfileRequestBody instance,
) => <String, dynamic>{
  'birthDate': instance.birthDate,
  'gender': instance.gender,
  'address': instance.address,
  'bloodType': instance.bloodType,
};
