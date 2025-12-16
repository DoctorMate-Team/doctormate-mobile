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
      description: json['description'] as String,
      recordType: json['recordType'] as String,
      status: json['status'] as String,
      patientId: json['patientId'] as String,
      patientName: json['patientName'] as String,
      doctorId: json['doctorId'] as String?,
      doctorName: json['doctorName'] as String?,
      recordedBy: json['recordedBy'] as String,
      recordedAt: json['recordedAt'] as String,
    );

Map<String, dynamic> _$MedicalRecordModelToJson(MedicalRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'recordType': instance.recordType,
      'status': instance.status,
      'patientId': instance.patientId,
      'patientName': instance.patientName,
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'recordedBy': instance.recordedBy,
      'recordedAt': instance.recordedAt,
    };
