import 'package:json_annotation/json_annotation.dart';

part 'appointment_details_response.g.dart';

@JsonSerializable()
class AppointmentDetailsResponse {
  final String id;
  final DateTime scheduledStart;
  final DateTime scheduledEnd;
  final String status;
  final String reason;
  final String appointmentType;
  final double price;
  final String doctorId;
  final String doctorUserId;
  final String doctorName;
  final String doctorImage;
  final String specialty;
  final String patientId;
  final String patientUserId;
  final String patientName;
  final String patientImage;
  final String patientPhone;
  final String patientGender;
  final int patientAge;
  final MedicalRecord? medicalRecord;
  final List<Diagnosis> diagnoses;
  final List<Prescription> prescriptions;
  final List<MedicalImage> medicalImages;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AppointmentDetailsResponse({
    required this.id,
    required this.scheduledStart,
    required this.scheduledEnd,
    required this.status,
    required this.reason,
    required this.appointmentType,
    required this.price,
    required this.doctorId,
    required this.doctorUserId,
    required this.doctorName,
    required this.doctorImage,
    required this.specialty,
    required this.patientId,
    required this.patientUserId,
    required this.patientName,
    required this.patientImage,
    required this.patientPhone,
    required this.patientGender,
    required this.patientAge,
    required this.medicalRecord,
    required this.diagnoses,
    required this.prescriptions,
    required this.medicalImages,
    required this.createdAt,
    this.updatedAt,
  });

  factory AppointmentDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentDetailsResponseFromJson(json);
}

@JsonSerializable()
class MedicalRecord {
  final String id;
  final String title;
  final String recordType;
  final DateTime recordDate;

  MedicalRecord({
    required this.id,
    required this.title,
    required this.recordType,
    required this.recordDate,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordFromJson(json);
}

@JsonSerializable()
class Diagnosis {
  final String id;
  final String medicalRecordId;
  final String medicalRecordTitle;
  final String? appointmentId;
  final String diagnosedBy;
  final String? doctorName;
  final String description;
  final String icdCode;
  final String severity;
  final String? openmrsConditionUuid;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Diagnosis({
    required this.id,
    required this.medicalRecordId,
    required this.medicalRecordTitle,
    this.appointmentId,
    required this.diagnosedBy,
    this.doctorName,
    required this.description,
    required this.icdCode,
    required this.severity,
    this.openmrsConditionUuid,
    required this.createdAt,
    this.updatedAt,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFromJson(json);
}

@JsonSerializable()
class MedicalImage {
  final String id;
  final String appointmentId;
  final String patientId;
  final String? doctorId;
  final String? requestedByRole;
  final String fileName;
  final String fileType;
  final int fileSize;
  final String description;
  final String? tags;
  final String? doctorNotes;
  final bool isCritical;
  final String status;
  final String? pacsRefId;
  final String? studyInstanceUid;
  final String? modality;
  final DateTime? studyDate;
  final bool isSyncedToPacs;
  final String viewerUrl;
  final String? uploadedByRole;
  final DateTime createdAt;

  MedicalImage({
    required this.id,
    required this.appointmentId,
    required this.patientId,
    this.doctorId,
    this.requestedByRole,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.description,
    this.tags,
    this.doctorNotes,
    required this.isCritical,
    required this.status,
    this.pacsRefId,
    this.studyInstanceUid,
    this.modality,
    this.studyDate,
    required this.isSyncedToPacs,
    required this.viewerUrl,
    this.uploadedByRole,
    required this.createdAt,
  });

  factory MedicalImage.fromJson(Map<String, dynamic> json) =>
      _$MedicalImageFromJson(json);
}

@JsonSerializable()
class Prescription {
  final String id;
  final String diagnosisId;
  final String patientId;
  final String doctorId;
  final String appointmentId;
  final String? notes;
  final List<Medication> medications;

  Prescription({
    required this.id,
    required this.diagnosisId,
    required this.patientId,
    required this.doctorId,
    required this.appointmentId,
    this.notes,
    required this.medications,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionFromJson(json);
}

@JsonSerializable()
class Medication {
  final String id;
  final String drugName;
  final String dosage;
  final String frequency;
  final String instructions;
  final int durationDays;

  Medication({
    required this.id,
    required this.drugName,
    required this.dosage,
    required this.frequency,
    required this.instructions,
    required this.durationDays,
  });

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);
}

/*
{
    "code": 200,
    "message": "Appointment details retrieved successfully",
    "data": {
        "id": "5a26be8f-46a0-401b-aa79-9895a63fc5bb",
        "scheduledStart": "2026-02-05T09:00:00",
        "scheduledEnd": "2026-02-05T09:15:00",
        "status": "completed",
        "reason": "New Symptoms",
        "appointmentType": "video",
        "price": 300.00,
        "doctorId": "6259420f-b64f-4156-a3ae-08de29ac6dce",
        "doctorUserId": "eafd8646-56be-4c97-a8c7-08de29ac6db4",
        "doctorName": "Mohamed",
        "doctorImage": "https://res.cloudinary.com/dukkhnflu/image/upload/v1764167955/doctormate/users/tjmzqwhmgqlruytvrttn.png",
        "specialty": "Cardiology",
        "patientId": "d3739eae-357d-4828-66f3-08de1872d053",
        "patientUserId": "a39c9498-a4e8-4ba6-070e-08de1872d033",
        "patientName": "Mohamed Reda",
        "patientImage": "https://res.cloudinary.com/dukkhnflu/image/upload/v1763384304/doctormate/users/ygtz73fw7m8l1uh0a7gk.jpg",
        "patientPhone": "01021236489",
        "patientGender": "Male",
        "patientAge": 21,
        "medicalRecord": {
            "id": "df844d32-5ae6-465a-85ba-e27ae27d44e8",
            "title": "Diabetes Mellitus",
            "recordType": "diagnosis",
            "recordDate": "2026-02-04T14:55:18.8110232"
        },
        "diagnoses": [
            {
                "id": "a0ee6ca9-785c-44f8-913c-d62dc918eb8f",
                "medicalRecordId": "df844d32-5ae6-465a-85ba-e27ae27d44e8",
                "medicalRecordTitle": "Diabetes Mellitus",
                "appointmentId": null,
                "diagnosedBy": "00000000-0000-0000-0000-000000000000",
                "doctorName": null,
                "description": "Hypertension - Stage 2. Blood pressure 160/100 mmHg.",
                "icdCode": "I11",
                "severity": "severe",
                "openmrsConditionUuid": null,
                "createdAt": "2026-02-04T14:57:15.7153667",
                "updatedAt": null,
                "patient": null,
                "doctor": null,
                "appointment": null,
                "medicalRecord": null
            }
        ],
        "prescriptions": [
            {
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
        "medicalImages": [
        {
                "id": "537a1777-c99e-427d-ad57-1873483911ae",
                "appointmentId": "00000000-0000-0000-0000-000000000000",
                "patientId": "00000000-0000-0000-0000-000000000000",
                "doctorId": null,
                "requestedByRole": null,
                "fileName": "cristiano-ronaldo-4k-hd-download-for-pc-wallpaper-preview.jpg",
                "fileType": ".jpg",
                "fileSize": 49615,
                "description": "test2",
                "tags": null,
                "doctorNotes": null,
                "isCritical": false,
                "status": "uploaded",
                "pacsRefId": null,
                "studyInstanceUid": null,
                "modality": null,
                "studyDate": null,
                "isSyncedToPacs": false,
                "viewerUrl": "uploads/medical-images\\9fd696cc-e548-47cd-a1a3-d230893831e1_cristiano-ronaldo-4k-hd-download-for-pc-wallpaper-preview.jpg",
                "uploadedByRole": null,
                "canDelete": false,
                "canEdit": false,
                "createdAt": "2026-02-13T13:16:55.7818118"
            },],
        "createdAt": "2026-02-04T14:54:10",
        "updatedAt": null
    }
}
*/
