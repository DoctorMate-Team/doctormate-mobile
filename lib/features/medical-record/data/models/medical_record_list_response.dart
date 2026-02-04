import 'package:doctor_mate/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_record_list_response.g.dart';

@JsonSerializable()
class MedicalRecordListResponse {
  final Pagination pagination;
  final List<MedicalRecordModel> records;

  MedicalRecordListResponse({required this.pagination, required this.records});

  factory MedicalRecordListResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordListResponseToJson(this);
}

@JsonSerializable()
class MedicalRecordModel {
  final String id;
  final String title;
  final String recordType;
  final DateTime recordedAt;
  final List<DiagnosisModel>? diagnoses;

  MedicalRecordModel({
    required this.id,
    required this.title,
    required this.recordType,
    required this.recordedAt,
    this.diagnoses,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordModelToJson(this);
}

@JsonSerializable()
class DiagnosisModel {
  final String id;
  final String medicalRecordId;
  final String appointmentId;
  final String description;
  final String icdCode;
  final String severity;
  final String doctorName;
  final DateTime createdAt;

  DiagnosisModel({
    required this.id,
    required this.medicalRecordId,
    required this.appointmentId,
    required this.description,
    required this.icdCode,
    required this.severity,
    required this.doctorName,
    required this.createdAt,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisModelToJson(this);
}

/*
{
    "code": 200,
    "message": "Medical records retrieved successfully",
    "data": {
        "pagination": {
            "page": 1,
            "limit": 10,
            "totalItems": 1,
            "totalPages": 1
        },
        "records": [
            {
                "id": "bad2a763-cfe9-47b8-8e13-92ce1f15d178",
                "title": "Type 2 Diabetes Mellitus",
                "recordType": "diagnosis",
                "recordedAt": "2026-02-04T13:48:13.6817846",
                "diagnoses": [
                    {
                        "id": "5f4381ad-cca7-4382-b8e0-f36ce470f69a",
                        "medicalRecordId": "bad2a763-cfe9-47b8-8e13-92ce1f15d178",
                        "appointmentId": "693bf3db-e67e-476f-b078-06e9678a2c21",
                        "description": "Hypertension - Stage 2. Blood pressure 160/100 mmHg.",
                        "icdCode": "I10",
                        "severity": "severe",
                        "doctorName": "Mohamed",
                        "createdAt": "2026-02-04T14:03:40.414368"
                    }
                ]
            }
        ]
    }
}
*/
