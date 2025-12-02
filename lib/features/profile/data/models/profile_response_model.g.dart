// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponseModel _$ProfileResponseModelFromJson(
  Map<String, dynamic> json,
) => ProfileResponseModel(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  imageUrl: json['imageUrl'] as String?,
  role: json['role'] as String,
  birthDate: DateTime.parse(json['birthDate'] as String),
  gender: json['gender'] as String,
  address: json['address'] as String,
  bloodType: json['bloodType'] as String,
  emergencyContact: json['emergencyContact'] as String?,
  openmrsPatientUuid: json['openmrsPatientUuid'] as String?,
);

Map<String, dynamic> _$ProfileResponseModelToJson(
  ProfileResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'imageUrl': instance.imageUrl,
  'role': instance.role,
  'birthDate': instance.birthDate.toIso8601String(),
  'gender': instance.gender,
  'address': instance.address,
  'bloodType': instance.bloodType,
  'emergencyContact': instance.emergencyContact,
  'openmrsPatientUuid': instance.openmrsPatientUuid,
};
