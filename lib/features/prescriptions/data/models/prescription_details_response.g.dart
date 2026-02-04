// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionDetailsResponse _$PrescriptionDetailsResponseFromJson(
  Map<String, dynamic> json,
) => PrescriptionDetailsResponse(
  id: json['id'] as String,
  diagnosisId: json['diagnosisId'] as String,
  patientId: json['patientId'] as String,
  doctorId: json['doctorId'] as String,
  appointmentId: json['appointmentId'] as String,
  notes: json['notes'] as String?,
  medications:
      (json['medications'] as List<dynamic>)
          .map(
            (e) =>
                PrescriptionMedicationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  patient:
      json['patient'] == null
          ? null
          : PatientModel.fromJson(json['patient'] as Map<String, dynamic>),
  doctor:
      json['doctor'] == null
          ? null
          : DoctorModel.fromJson(json['doctor'] as Map<String, dynamic>),
  diagnosis:
      json['diagnosis'] == null
          ? null
          : DiagnosisModel.fromJson(json['diagnosis'] as Map<String, dynamic>),
  appointment:
      json['appointment'] == null
          ? null
          : AppointmentModel.fromJson(
            json['appointment'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$PrescriptionDetailsResponseToJson(
  PrescriptionDetailsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'diagnosisId': instance.diagnosisId,
  'patientId': instance.patientId,
  'doctorId': instance.doctorId,
  'appointmentId': instance.appointmentId,
  'notes': instance.notes,
  'medications': instance.medications,
  'patient': instance.patient,
  'doctor': instance.doctor,
  'diagnosis': instance.diagnosis,
  'appointment': instance.appointment,
};

PrescriptionMedicationModel _$PrescriptionMedicationModelFromJson(
  Map<String, dynamic> json,
) => PrescriptionMedicationModel(
  id: json['id'] as String,
  drugName: json['drugName'] as String,
  dosage: json['dosage'] as String,
  frequency: json['frequency'] as String,
  instructions: json['instructions'] as String,
  durationDays: (json['durationDays'] as num).toInt(),
);

Map<String, dynamic> _$PrescriptionMedicationModelToJson(
  PrescriptionMedicationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'drugName': instance.drugName,
  'dosage': instance.dosage,
  'frequency': instance.frequency,
  'instructions': instance.instructions,
  'durationDays': instance.durationDays,
};

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
  id: json['id'] as String,
  name: json['name'] as String,
  image: json['image'] as String?,
);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  id: json['id'] as String,
  name: json['name'] as String,
  image: json['image'] as String?,
  specialty: json['specialty'] as String?,
);

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'specialty': instance.specialty,
    };

DiagnosisModel _$DiagnosisModelFromJson(Map<String, dynamic> json) =>
    DiagnosisModel(
      id: json['id'] as String,
      description: json['description'] as String,
      icdCode: json['icdCode'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$DiagnosisModelToJson(DiagnosisModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'icdCode': instance.icdCode,
      'severity': instance.severity,
    };

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['id'] as String,
      scheduledStart: json['scheduledStart'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduledStart': instance.scheduledStart,
      'status': instance.status,
    };
