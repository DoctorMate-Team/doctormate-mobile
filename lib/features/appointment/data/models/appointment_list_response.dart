import 'package:doctor_mate/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment_list_response.g.dart';

@JsonSerializable()
class AppointmentListResponse {
  final Pagination pagination;
  final List<PatientAppointmentModel> appointments;

  AppointmentListResponse({
    required this.pagination,
    required this.appointments,
  });

  factory AppointmentListResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentListResponseToJson(this);
}

@JsonSerializable()
class PatientAppointmentModel {
  final String id;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String reason;
  final String status;
  final DateTime createdAt;
  final AppointmentDoctorModel doctor;

  PatientAppointmentModel({
    required this.id,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.reason,
    required this.status,
    required this.createdAt,
    required this.doctor,
  });

  factory PatientAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$PatientAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAppointmentModelToJson(this);
}

@JsonSerializable()
class AppointmentDoctorModel {
  final String id;
  final String doctorName;
  final String specialtyName;
  final double consultationFee;
  final String image;
  final String address;
  final String workingTime;

  AppointmentDoctorModel({
    required this.id,
    required this.doctorName,
    required this.specialtyName,
    required this.consultationFee,
    required this.image,
    required this.address,
    required this.workingTime,
  });

  factory AppointmentDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentDoctorModelToJson(this);
}
