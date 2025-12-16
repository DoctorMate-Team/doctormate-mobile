import 'package:json_annotation/json_annotation.dart';

part 'diagnosis_details_response.g.dart';

@JsonSerializable()
class DiagnosisDetailsResponse {
  final String id;
  final String medicalRecordId;
  final String medicalRecordTitle;
  final String appointmentId;
  final String diagnosedBy;
  final String doctorName;
  final String description;
  final String icdCode;
  final String severity;
  final String openmrsConditionUuid;
  final String createdAt;
  final String updatedAt;
  final PatientInfoModel patient;
  final DiagnosisDoctorModel doctor;
  final DiagnosisAppointmentModel appointment;
  final DiagnosisMedicalRecordModel medicalRecord;

  DiagnosisDetailsResponse({
    required this.id,
    required this.medicalRecordId,
    required this.medicalRecordTitle,
    required this.appointmentId,
    required this.diagnosedBy,
    required this.doctorName,
    required this.description,
    required this.icdCode,
    required this.severity,
    required this.openmrsConditionUuid,
    required this.createdAt,
    required this.updatedAt,
    required this.patient,
    required this.doctor,
    required this.appointment,
    required this.medicalRecord,
  });

  factory DiagnosisDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisDetailsResponseToJson(this);
}

@JsonSerializable()
class PatientInfoModel {
  final String id;
  final String name;
  final String? image;
  final String gender;
  final int age;

  PatientInfoModel({
    required this.id,
    required this.name,
    this.image,
    required this.gender,
    required this.age,
  });

  factory PatientInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PatientInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInfoModelToJson(this);
}

@JsonSerializable()
class DiagnosisDoctorModel {
  final String id;
  final String name;
  final String? image;
  final String specialtyName;
  final double consultationFee;

  DiagnosisDoctorModel({
    required this.id,
    required this.name,
    this.image,
    required this.specialtyName,
    required this.consultationFee,
  });

  factory DiagnosisDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisDoctorModelToJson(this);
}

@JsonSerializable()
class DiagnosisAppointmentModel {
  final String id;
  final String scheduledAt;
  final String status;
  final String reasonForVisit;

  DiagnosisAppointmentModel({
    required this.id,
    required this.scheduledAt,
    required this.status,
    required this.reasonForVisit,
  });

  factory DiagnosisAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisAppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisAppointmentModelToJson(this);
}

@JsonSerializable()
class DiagnosisMedicalRecordModel {
  final String id;
  final String title;
  final String recordType;
  final String recordDate;

  DiagnosisMedicalRecordModel({
    required this.id,
    required this.title,
    required this.recordType,
    required this.recordDate,
  });

  factory DiagnosisMedicalRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisMedicalRecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisMedicalRecordModelToJson(this);
}
