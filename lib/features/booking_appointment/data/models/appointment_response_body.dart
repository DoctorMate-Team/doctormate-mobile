import 'package:json_annotation/json_annotation.dart';

part 'appointment_response_body.g.dart';
@JsonSerializable()
class AppointmentResponseBody {
  final AppointmentModel appointment;

  AppointmentResponseBody({
    required this.appointment,
  });

  factory AppointmentResponseBody.fromJson(Map<String, dynamic> json) =>
      _$AppointmentResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentResponseBodyToJson(this);
}

@JsonSerializable()
class AppointmentModel {
  final String id;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String status;
  final String reason;
  final String appointmentType;
  final DateTime createdAt;
  final PatientModel patient;
  final DoctorModel doctor;

  AppointmentModel({
    required this.id,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.reason,
    required this.appointmentType,
    required this.createdAt,
    required this.patient,
    required this.doctor,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}

@JsonSerializable()
class PatientModel {
  final String id;
  final String name;
  final String image;
  final String gender;
  final int age;

  PatientModel({
    required this.id,
    required this.name,
    required this.image,
    required this.gender,
    required this.age,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}

@JsonSerializable()
class DoctorModel {
  final String id;
  final String doctorName;
  final String specialtyName;
  final double consultationFee;
  final String image;
  final String address;
  final String workingTime;

  DoctorModel({
    required this.id,
    required this.doctorName,
    required this.specialtyName,
    required this.consultationFee,
    required this.image,
    required this.address,
    required this.workingTime,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}

/*
{
    "code": 0,
    "message": "string",
    "data": {
        "appointment": {
            "id": "string",
            "appointmentDate": "2019-08-24T14:15:22Z",
            "appointmentTime": "14:15:22Z",
            "status": "string",
            "reason": "string",
            "appointmentType": "string",
            "createdAt": "2019-08-24T14:15:22Z",
            "patient": {
                "id": "string",
                "name": "string",
                "image": "string",
                "gender": "string",
                "age": 0
            },
            "doctor": {
                "id": "string",
                "doctorName": "string",
                "specialtyName": "string",
                "consultationFee": 0,
                "image": "string",
                "address": "string",
                "workingTime": "string"
            }
        }
    }
}
*/