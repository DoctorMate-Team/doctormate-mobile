import 'package:json_annotation/json_annotation.dart';

part 'prescription_details_response.g.dart';

@JsonSerializable()
class PrescriptionDetailsResponse {
  final String id;
  final String diagnosisId;
  final String patientId;
  final String doctorId;
  final String appointmentId;
  final String? notes;
  final List<PrescriptionMedicationModel> medications;
  final PatientModel? patient;
  final DoctorModel? doctor;
  final DiagnosisModel? diagnosis;
  final AppointmentModel? appointment;

  PrescriptionDetailsResponse({
    required this.id,
    required this.diagnosisId,
    required this.patientId,
    required this.doctorId,
    required this.appointmentId,
    this.notes,
    required this.medications,
    this.patient,
    this.doctor,
    this.diagnosis,
    this.appointment,
  });

  factory PrescriptionDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionDetailsResponseToJson(this);
}

@JsonSerializable()
class PrescriptionMedicationModel {
  final String id;
  final String drugName;
  final String dosage;
  final String frequency;
  final String instructions;
  final int durationDays;

  PrescriptionMedicationModel({
    required this.id,
    required this.drugName,
    required this.dosage,
    required this.frequency,
    required this.instructions,
    required this.durationDays,
  });

  factory PrescriptionMedicationModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionMedicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionMedicationModelToJson(this);
}

@JsonSerializable()
class PatientModel {
  final String id;
  final String name;
  final String? image;

  PatientModel({required this.id, required this.name, this.image});

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}

@JsonSerializable()
class DoctorModel {
  final String id;
  final String name;
  final String? image;
  final String? specialty;

  DoctorModel({
    required this.id,
    required this.name,
    this.image,
    this.specialty,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}

@JsonSerializable()
class DiagnosisModel {
  final String id;
  final String description;
  final String icdCode;
  final String severity;

  DiagnosisModel({
    required this.id,
    required this.description,
    required this.icdCode,
    required this.severity,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisModelToJson(this);
}

@JsonSerializable()
class AppointmentModel {
  final String id;
  final String scheduledStart;
  final String status;

  AppointmentModel({
    required this.id,
    required this.scheduledStart,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);
}
/*
{
    "code": 200,
    "message": "Prescription retrieved successfully",
    "data": {
        "id": "60841ea0-bced-4bb7-aca7-4de90c6b1aab",
        "diagnosisId": "a0ee6ca9-785c-44f8-913c-d62dc918eb8f",
        "patientId": "d3739eae-357d-4828-66f3-08de1872d053",
        "doctorId": "6259420f-b64f-4156-a3ae-08de29ac6dce",
        "appointmentId": "5a26be8f-46a0-401b-aa79-9895a63fc5bb",
        "notes": null,
        "medications": [
            {
                "id": "088a91ee-149c-4fd3-a413-543d66ba856e",
                "drugName": "Amoxicillin",
                "dosage": "500mg",
                "frequency": "Every 6 hours as needed",
                "instructions": "Take with food, 3 times daily",
                "durationDays": 7
            },
            {
                "id": "dcf16471-9214-4fda-a42b-b31326e04017",
                "drugName": "Paracetamol",
                "dosage": "500mg",
                "frequency": "Every 6 hours as needed",
                "instructions": "Every 6 hours as needed",
                "durationDays": 5
            },
            {
                "id": "1ad29c94-d627-4810-b451-f4502246bde2",
                "drugName": "Vitamin C",
                "dosage": "1000mg",
                "frequency": "Every 6 hours as needed",
                "instructions": "Once daily in the morning",
                "durationDays": 30
            }
        ],
        "openmrsOrderUuid": null,
        "createdAt": "2026-02-04T14:58:06.6865133",
        "updatedAt": null,
        "patient": {
            "id": "d3739eae-357d-4828-66f3-08de1872d053",
            "name": "Mohamed Reda",
            "image": "https://res.cloudinary.com/dukkhnflu/image/upload/v1763384304/doctormate/users/ygtz73fw7m8l1uh0a7gk.jpg"
        },
        "doctor": {
            "id": "6259420f-b64f-4156-a3ae-08de29ac6dce",
            "name": "Mohamed",
            "image": "https://res.cloudinary.com/dukkhnflu/image/upload/v1764167955/doctormate/users/tjmzqwhmgqlruytvrttn.png",
            "specialty": null
        },
        "diagnosis": {
            "id": "a0ee6ca9-785c-44f8-913c-d62dc918eb8f",
            "description": "Hypertension - Stage 2. Blood pressure 160/100 mmHg.",
            "icdCode": "I11",
            "severity": "severe"
        },
        "appointment": {
            "id": "5a26be8f-46a0-401b-aa79-9895a63fc5bb",
            "scheduledStart": "2026-02-05T09:00:00",
            "status": "completed"
        }
    }
}
*/