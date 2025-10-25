// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_mate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorMateResponse<T> _$DoctorMateResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => DoctorMateResponse<T>(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
  data: fromJsonT(json['data']),
);

Map<String, dynamic> _$DoctorMateResponseToJson<T>(
  DoctorMateResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'data': toJsonT(instance.data),
};
