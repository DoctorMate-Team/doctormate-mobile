// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentListResponse _$AppointmentListResponseFromJson(
  Map<String, dynamic> json,
) => AppointmentListResponse(
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  appointments:
      (json['appointments'] as List<dynamic>)
          .map(
            (e) => PatientAppointmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$AppointmentListResponseToJson(
  AppointmentListResponse instance,
) => <String, dynamic>{
  'pagination': instance.pagination,
  'appointments': instance.appointments,
};

PatientAppointmentModel _$PatientAppointmentModelFromJson(
  Map<String, dynamic> json,
) => PatientAppointmentModel(
  id: json['id'] as String,
  appointmentDate: DateTime.parse(json['appointmentDate'] as String),
  appointmentTime: json['appointmentTime'] as String,
  reason: json['reason'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  doctor: AppointmentDoctorModel.fromJson(
    json['doctor'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PatientAppointmentModelToJson(
  PatientAppointmentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'appointmentDate': instance.appointmentDate.toIso8601String(),
  'appointmentTime': instance.appointmentTime,
  'reason': instance.reason,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
  'doctor': instance.doctor,
};

AppointmentDoctorModel _$AppointmentDoctorModelFromJson(
  Map<String, dynamic> json,
) => AppointmentDoctorModel(
  id: json['id'] as String,
  doctorName: json['doctorName'] as String,
  specialtyName: json['specialtyName'] as String,
  consultationFee: (json['consultationFee'] as num).toDouble(),
  image: json['image'] as String,
  address: json['address'] as String,
  workingTime: json['workingTime'] as String,
);

Map<String, dynamic> _$AppointmentDoctorModelToJson(
  AppointmentDoctorModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'doctorName': instance.doctorName,
  'specialtyName': instance.specialtyName,
  'consultationFee': instance.consultationFee,
  'image': instance.image,
  'address': instance.address,
  'workingTime': instance.workingTime,
};
