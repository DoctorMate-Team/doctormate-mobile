// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiagnosisDetailsResponse _$DiagnosisDetailsResponseFromJson(
  Map<String, dynamic> json,
) => DiagnosisDetailsResponse(
  id: json['id'] as String,
  medicalRecordId: json['medicalRecordId'] as String,
  medicalRecordTitle: json['medicalRecordTitle'] as String,
  appointmentId: json['appointmentId'] as String,
  diagnosedBy: json['diagnosedBy'] as String,
  doctorName: json['doctorName'] as String,
  description: json['description'] as String,
  icdCode: json['icdCode'] as String,
  severity: json['severity'] as String,
  openmrsConditionUuid: json['openmrsConditionUuid'] as String,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  patient: PatientInfoModel.fromJson(json['patient'] as Map<String, dynamic>),
  doctor: DiagnosisDoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
  appointment: DiagnosisAppointmentModel.fromJson(
    json['appointment'] as Map<String, dynamic>,
  ),
  medicalRecord: DiagnosisMedicalRecordModel.fromJson(
    json['medicalRecord'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$DiagnosisDetailsResponseToJson(
  DiagnosisDetailsResponse instance,
) => <String, dynamic>{
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
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'patient': instance.patient,
  'doctor': instance.doctor,
  'appointment': instance.appointment,
  'medicalRecord': instance.medicalRecord,
};

PatientInfoModel _$PatientInfoModelFromJson(Map<String, dynamic> json) =>
    PatientInfoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      gender: json['gender'] as String,
      age: (json['age'] as num).toInt(),
    );

Map<String, dynamic> _$PatientInfoModelToJson(PatientInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'gender': instance.gender,
      'age': instance.age,
    };

DiagnosisDoctorModel _$DiagnosisDoctorModelFromJson(
  Map<String, dynamic> json,
) => DiagnosisDoctorModel(
  id: json['id'] as String,
  name: json['name'] as String,
  image: json['image'] as String?,
  specialtyName: json['specialtyName'] as String,
  consultationFee: (json['consultationFee'] as num).toDouble(),
);

Map<String, dynamic> _$DiagnosisDoctorModelToJson(
  DiagnosisDoctorModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': instance.image,
  'specialtyName': instance.specialtyName,
  'consultationFee': instance.consultationFee,
};

DiagnosisAppointmentModel _$DiagnosisAppointmentModelFromJson(
  Map<String, dynamic> json,
) => DiagnosisAppointmentModel(
  id: json['id'] as String,
  scheduledAt: json['scheduledAt'] as String,
  status: json['status'] as String,
  reasonForVisit: json['reasonForVisit'] as String,
);

Map<String, dynamic> _$DiagnosisAppointmentModelToJson(
  DiagnosisAppointmentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'scheduledAt': instance.scheduledAt,
  'status': instance.status,
  'reasonForVisit': instance.reasonForVisit,
};

DiagnosisMedicalRecordModel _$DiagnosisMedicalRecordModelFromJson(
  Map<String, dynamic> json,
) => DiagnosisMedicalRecordModel(
  id: json['id'] as String,
  title: json['title'] as String,
  recordType: json['recordType'] as String,
  recordDate: json['recordDate'] as String,
);

Map<String, dynamic> _$DiagnosisMedicalRecordModelToJson(
  DiagnosisMedicalRecordModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'recordType': instance.recordType,
  'recordDate': instance.recordDate,
};
