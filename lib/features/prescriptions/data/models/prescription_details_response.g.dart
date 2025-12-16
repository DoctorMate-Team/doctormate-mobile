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
  patientName: json['patientName'] as String,
  patientImage: json['patientImage'] as String?,
  doctorId: json['doctorId'] as String,
  doctorName: json['doctorName'] as String,
  doctorImage: json['doctorImage'] as String?,
  specialtyName: json['specialtyName'] as String,
  prescribedDate: json['prescribedDate'] as String,
  expiryDate: json['expiryDate'] as String?,
  status: json['status'] as String,
  notes: json['notes'] as String?,
  medications:
      (json['medications'] as List<dynamic>)
          .map(
            (e) =>
                PrescriptionMedicationModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$PrescriptionDetailsResponseToJson(
  PrescriptionDetailsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'diagnosisId': instance.diagnosisId,
  'patientId': instance.patientId,
  'patientName': instance.patientName,
  'patientImage': instance.patientImage,
  'doctorId': instance.doctorId,
  'doctorName': instance.doctorName,
  'doctorImage': instance.doctorImage,
  'specialtyName': instance.specialtyName,
  'prescribedDate': instance.prescribedDate,
  'expiryDate': instance.expiryDate,
  'status': instance.status,
  'notes': instance.notes,
  'medications': instance.medications,
};

PrescriptionMedicationModel _$PrescriptionMedicationModelFromJson(
  Map<String, dynamic> json,
) => PrescriptionMedicationModel(
  drugName: json['drugName'] as String,
  dosage: json['dosage'] as String?,
  instructions: json['instructions'] as String?,
  durationDays: (json['durationDays'] as num?)?.toInt(),
);

Map<String, dynamic> _$PrescriptionMedicationModelToJson(
  PrescriptionMedicationModel instance,
) => <String, dynamic>{
  'drugName': instance.drugName,
  'dosage': instance.dosage,
  'instructions': instance.instructions,
  'durationDays': instance.durationDays,
};
