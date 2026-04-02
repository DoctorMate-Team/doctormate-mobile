// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentRequestBody _$AppointmentRequestBodyFromJson(
  Map<String, dynamic> json,
) => AppointmentRequestBody(
  doctorId: json['doctorId'] as String,
  appointmentDate: json['appointmentDate'] as String,
  appointmentTime: json['appointmentTime'] as String,
  reason: json['reason'] as String,
  appointmentType: json['appointmentType'] as String,
  paymentMethod: json['paymentMethod'] as String,
);

Map<String, dynamic> _$AppointmentRequestBodyToJson(
  AppointmentRequestBody instance,
) => <String, dynamic>{
  'doctorId': instance.doctorId,
  'appointmentDate': instance.appointmentDate,
  'appointmentTime': instance.appointmentTime,
  'reason': instance.reason,
  'appointmentType': instance.appointmentType,
  'paymentMethod': instance.paymentMethod,
};
