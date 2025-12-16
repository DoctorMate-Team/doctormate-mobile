import 'package:doctor_mate/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_record_list_response.g.dart';

@JsonSerializable()
class MedicalRecordListResponse {
  final Pagination pagination;
  final List<MedicalRecordModel> records;

  MedicalRecordListResponse({
    required this.pagination,
    required this.records,
  });

  factory MedicalRecordListResponse.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordListResponseToJson(this);
}

@JsonSerializable()
class MedicalRecordModel {
  final String id;
  final String title;
  final String description;
  final String recordType;
  final String status;
  final String patientId;
  final String patientName;
  final String? doctorId;
  final String? doctorName;
  final String recordedBy;
  final String recordedAt;

  MedicalRecordModel({
    required this.id,
    required this.title,
    required this.description,
    required this.recordType,
    required this.status,
    required this.patientId,
    required this.patientName,
    this.doctorId,
    this.doctorName,
    required this.recordedBy,
    required this.recordedAt,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) =>
      _$MedicalRecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalRecordModelToJson(this);
}
