// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentDetailsResponse _$AppointmentDetailsResponseFromJson(
  Map<String, dynamic> json,
) => AppointmentDetailsResponse(
  id: json['id'] as String,
  scheduledStart: DateTime.parse(json['scheduledStart'] as String),
  scheduledEnd: DateTime.parse(json['scheduledEnd'] as String),
  status: json['status'] as String,
  reason: json['reason'] as String,
  appointmentType: json['appointmentType'] as String,
  price: (json['price'] as num).toDouble(),
  doctorId: json['doctorId'] as String,
  doctorUserId: json['doctorUserId'] as String,
  doctorName: json['doctorName'] as String,
  doctorImage: json['doctorImage'] as String,
  specialty: json['specialty'] as String,
  patientId: json['patientId'] as String,
  patientUserId: json['patientUserId'] as String,
  patientName: json['patientName'] as String,
  patientImage: json['patientImage'] as String,
  patientPhone: json['patientPhone'] as String,
  patientGender: json['patientGender'] as String,
  patientAge: (json['patientAge'] as num).toInt(),
  medicalRecord:
      json['medicalRecord'] == null
          ? null
          : MedicalRecord.fromJson(
            json['medicalRecord'] as Map<String, dynamic>,
          ),
  diagnoses:
      (json['diagnoses'] as List<dynamic>)
          .map((e) => Diagnosis.fromJson(e as Map<String, dynamic>))
          .toList(),
  prescriptions:
      (json['prescriptions'] as List<dynamic>)
          .map((e) => Prescription.fromJson(e as Map<String, dynamic>))
          .toList(),
  medicalImages:
      (json['medicalImages'] as List<dynamic>)
          .map((e) => MedicalImage.fromJson(e as Map<String, dynamic>))
          .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AppointmentDetailsResponseToJson(
  AppointmentDetailsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'scheduledStart': instance.scheduledStart.toIso8601String(),
  'scheduledEnd': instance.scheduledEnd.toIso8601String(),
  'status': instance.status,
  'reason': instance.reason,
  'appointmentType': instance.appointmentType,
  'price': instance.price,
  'doctorId': instance.doctorId,
  'doctorUserId': instance.doctorUserId,
  'doctorName': instance.doctorName,
  'doctorImage': instance.doctorImage,
  'specialty': instance.specialty,
  'patientId': instance.patientId,
  'patientUserId': instance.patientUserId,
  'patientName': instance.patientName,
  'patientImage': instance.patientImage,
  'patientPhone': instance.patientPhone,
  'patientGender': instance.patientGender,
  'patientAge': instance.patientAge,
  'medicalRecord': instance.medicalRecord,
  'diagnoses': instance.diagnoses,
  'prescriptions': instance.prescriptions,
  'medicalImages': instance.medicalImages,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

MedicalRecord _$MedicalRecordFromJson(Map<String, dynamic> json) =>
    MedicalRecord(
      id: json['id'] as String,
      title: json['title'] as String,
      recordType: json['recordType'] as String,
      recordDate: DateTime.parse(json['recordDate'] as String),
    );

Map<String, dynamic> _$MedicalRecordToJson(MedicalRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'recordType': instance.recordType,
      'recordDate': instance.recordDate.toIso8601String(),
    };

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) => Diagnosis(
  id: json['id'] as String,
  medicalRecordId: json['medicalRecordId'] as String,
  medicalRecordTitle: json['medicalRecordTitle'] as String,
  appointmentId: json['appointmentId'] as String?,
  diagnosedBy: json['diagnosedBy'] as String,
  doctorName: json['doctorName'] as String?,
  description: json['description'] as String,
  icdCode: json['icdCode'] as String,
  severity: json['severity'] as String,
  openmrsConditionUuid: json['openmrsConditionUuid'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DiagnosisToJson(Diagnosis instance) => <String, dynamic>{
  'id': instance.id,
  'medicalRecordId': instance.medicalRecordId,
  'medicalRecordTitle': instance.medicalRecordTitle,
  'appointmentId': instance.appointmentId,
  'diagnosedBy': instance.diagnosedBy,
  'doctorName': instance.doctorName,
  'description': instance.description,
  'icdCode': instance.icdCode,
  'severity': instance.severity,
  'openmrsConditionUuid': instance.openmrsConditionUuid,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

MedicalImage _$MedicalImageFromJson(Map<String, dynamic> json) => MedicalImage(
  id: json['id'] as String,
  appointmentId: json['appointmentId'] as String,
  patientId: json['patientId'] as String,
  doctorId: json['doctorId'] as String?,
  requestedByRole: json['requestedByRole'] as String?,
  fileName: json['fileName'] as String,
  fileType: json['fileType'] as String,
  fileSize: (json['fileSize'] as num).toInt(),
  description: json['description'] as String,
  tags: json['tags'] as String?,
  doctorNotes: json['doctorNotes'] as String?,
  isCritical: json['isCritical'] as bool,
  status: json['status'] as String,
  pacsRefId: json['pacsRefId'] as String?,
  studyInstanceUid: json['studyInstanceUid'] as String?,
  modality: json['modality'] as String?,
  studyDate:
      json['studyDate'] == null
          ? null
          : DateTime.parse(json['studyDate'] as String),
  isSyncedToPacs: json['isSyncedToPacs'] as bool,
  viewerUrl: json['viewerUrl'] as String,
  uploadedByRole: json['uploadedByRole'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$MedicalImageToJson(MedicalImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'requestedByRole': instance.requestedByRole,
      'fileName': instance.fileName,
      'fileType': instance.fileType,
      'fileSize': instance.fileSize,
      'description': instance.description,
      'tags': instance.tags,
      'doctorNotes': instance.doctorNotes,
      'isCritical': instance.isCritical,
      'status': instance.status,
      'pacsRefId': instance.pacsRefId,
      'studyInstanceUid': instance.studyInstanceUid,
      'modality': instance.modality,
      'studyDate': instance.studyDate?.toIso8601String(),
      'isSyncedToPacs': instance.isSyncedToPacs,
      'viewerUrl': instance.viewerUrl,
      'uploadedByRole': instance.uploadedByRole,
      'createdAt': instance.createdAt.toIso8601String(),
    };

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) => Prescription(
  id: json['id'] as String,
  diagnosisId: json['diagnosisId'] as String,
  patientId: json['patientId'] as String,
  doctorId: json['doctorId'] as String,
  appointmentId: json['appointmentId'] as String,
  notes: json['notes'] as String?,
  medications:
      (json['medications'] as List<dynamic>)
          .map((e) => Medication.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'diagnosisId': instance.diagnosisId,
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'appointmentId': instance.appointmentId,
      'notes': instance.notes,
      'medications': instance.medications,
    };

Medication _$MedicationFromJson(Map<String, dynamic> json) => Medication(
  id: json['id'] as String,
  drugName: json['drugName'] as String,
  dosage: json['dosage'] as String,
  frequency: json['frequency'] as String,
  instructions: json['instructions'] as String,
  durationDays: (json['durationDays'] as num).toInt(),
);

Map<String, dynamic> _$MedicationToJson(Medication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'drugName': instance.drugName,
      'dosage': instance.dosage,
      'frequency': instance.frequency,
      'instructions': instance.instructions,
      'durationDays': instance.durationDays,
    };
