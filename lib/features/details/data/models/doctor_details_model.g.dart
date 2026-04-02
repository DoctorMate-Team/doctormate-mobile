// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorDetailsModel _$DoctorDetailsModelFromJson(Map<String, dynamic> json) =>
    DoctorDetailsModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      specialty: json['specialty'] as String,
      imageUrl: json['imageUrl'] as String,
      consultationFee: (json['consultationFee'] as num).toDouble(),
      address: json['address'] as String,
      workingTime: json['workingTime'] as String,
      workingDays:
          (json['workingDays'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      qualifications: json['qualifications'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$DoctorDetailsModelToJson(DoctorDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'specialty': instance.specialty,
      'imageUrl': instance.imageUrl,
      'consultationFee': instance.consultationFee,
      'address': instance.address,
      'workingTime': instance.workingTime,
      'workingDays': instance.workingDays,
      'qualifications': instance.qualifications,
      'phoneNumber': instance.phoneNumber,
    };
