// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorSpecialtyResponse _$DoctorSpecialtyResponseFromJson(
  Map<String, dynamic> json,
) => DoctorSpecialtyResponse(
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  doctors:
      (json['doctors'] as List<dynamic>)
          .map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DoctorSpecialtyResponseToJson(
  DoctorSpecialtyResponse instance,
) => <String, dynamic>{
  'pagination': instance.pagination,
  'doctors': instance.doctors,
};

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  specialty: SpecialtyModel.fromJson(json['specialty'] as Map<String, dynamic>),
  imageUrl: json['imageUrl'] as String,
  consultationFee: (json['consultationFee'] as num).toDouble(),
  address: json['address'] as String,
  workingTime: json['workingTime'] as String,
  qualifications: json['qualifications'] as String,
  licenseNumber: json['licenseNumber'] as String,
);

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'specialty': instance.specialty,
      'imageUrl': instance.imageUrl,
      'consultationFee': instance.consultationFee,
      'address': instance.address,
      'workingTime': instance.workingTime,
      'qualifications': instance.qualifications,
      'licenseNumber': instance.licenseNumber,
    };
