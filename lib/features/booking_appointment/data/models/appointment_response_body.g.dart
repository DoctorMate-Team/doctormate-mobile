// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentResponseBody _$AppointmentResponseBodyFromJson(
  Map<String, dynamic> json,
) => AppointmentResponseBody(
  appointment: AppointmentModel.fromJson(
    json['appointment'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AppointmentResponseBodyToJson(
  AppointmentResponseBody instance,
) => <String, dynamic>{'appointment': instance.appointment};

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      appointmentTime: json['appointmentTime'] as String,
      status: json['status'] as String,
      reason: json['reason'] as String,
      appointmentType: json['appointmentType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      patient: PatientModel.fromJson(json['patient'] as Map<String, dynamic>),
      doctor: DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentDate': instance.appointmentDate.toIso8601String(),
      'appointmentTime': instance.appointmentTime,
      'status': instance.status,
      'reason': instance.reason,
      'appointmentType': instance.appointmentType,
      'createdAt': instance.createdAt.toIso8601String(),
      'patient': instance.patient,
      'doctor': instance.doctor,
    };

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
  id: json['id'] as String,
  name: json['name'] as String,
  image: json['image'] as String,
  gender: json['gender'] as String,
  age: (json['age'] as num).toInt(),
);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'gender': instance.gender,
      'age': instance.age,
    };

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  id: json['id'] as String,
  doctorName: json['doctorName'] as String,
  specialtyName: json['specialtyName'] as String,
  consultationFee: (json['consultationFee'] as num).toDouble(),
  image: json['image'] as String,
  address: json['address'] as String,
  workingTime: json['workingTime'] as String,
);

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorName': instance.doctorName,
      'specialtyName': instance.specialtyName,
      'consultationFee': instance.consultationFee,
      'image': instance.image,
      'address': instance.address,
      'workingTime': instance.workingTime,
    };
