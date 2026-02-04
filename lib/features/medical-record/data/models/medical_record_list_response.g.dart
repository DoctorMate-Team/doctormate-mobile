// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalRecordListResponse _$MedicalRecordListResponseFromJson(
  Map<String, dynamic> json,
) => MedicalRecordListResponse(
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
  records:
      (json['records'] as List<dynamic>)
          .map((e) => MedicalRecordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$MedicalRecordListResponseToJson(
  MedicalRecordListResponse instance,
) => <String, dynamic>{
  'pagination': instance.pagination,
  'records': instance.records,
};

MedicalRecordModel _$MedicalRecordModelFromJson(Map<String, dynamic> json) =>
    MedicalRecordModel(
      id: json['id'] as String,
      title: json['title'] as String,
      recordType: json['recordType'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      diagnoses:
          (json['diagnoses'] as List<dynamic>?)
              ?.map((e) => DiagnosisModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MedicalRecordModelToJson(MedicalRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'recordType': instance.recordType,
      'recordedAt': instance.recordedAt.toIso8601String(),
      'diagnoses': instance.diagnoses,
    };

DiagnosisModel _$DiagnosisModelFromJson(Map<String, dynamic> json) =>
    DiagnosisModel(
      id: json['id'] as String,
      medicalRecordId: json['medicalRecordId'] as String,
      appointmentId: json['appointmentId'] as String,
      description: json['description'] as String,
      icdCode: json['icdCode'] as String,
      severity: json['severity'] as String,
      doctorName: json['doctorName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$DiagnosisModelToJson(DiagnosisModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicalRecordId': instance.medicalRecordId,
      'appointmentId': instance.appointmentId,
      'description': instance.description,
      'icdCode': instance.icdCode,
      'severity': instance.severity,
      'doctorName': instance.doctorName,
      'createdAt': instance.createdAt.toIso8601String(),
    };
