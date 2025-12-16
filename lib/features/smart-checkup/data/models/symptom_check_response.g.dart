// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SymptomCheckResponse _$SymptomCheckResponseFromJson(
  Map<String, dynamic> json,
) => SymptomCheckResponse(
  id: json['id'] as String?,
  patientId: json['patientId'] as String?,
  patientName: json['patientName'] as String?,
  checkType: json['checkType'] as String?,
  symptoms: json['symptoms'] as String?,
  imageUrl: json['imageUrl'] as String?,
  diagnosis:
      json['diagnosis'] == null
          ? null
          : DiagnosisResultModel.fromJson(
            json['diagnosis'] as Map<String, dynamic>,
          ),
  recommendedDoctors:
      (json['recommendedDoctors'] as List<dynamic>?)
          ?.map(
            (e) => RecommendedDoctorModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$SymptomCheckResponseToJson(
  SymptomCheckResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'patientId': instance.patientId,
  'patientName': instance.patientName,
  'checkType': instance.checkType,
  'symptoms': instance.symptoms,
  'imageUrl': instance.imageUrl,
  'diagnosis': instance.diagnosis,
  'recommendedDoctors': instance.recommendedDoctors,
  'createdAt': instance.createdAt?.toIso8601String(),
};

DiagnosisResultModel _$DiagnosisResultModelFromJson(
  Map<String, dynamic> json,
) => DiagnosisResultModel(
  condition: json['condition'] as String?,
  description: json['description'] as String?,
  severity: json['severity'] as String?,
  confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
  possibleCauses:
      (json['possibleCauses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  recommendations:
      (json['recommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  warningSymptoms:
      (json['warningSymptoms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  requiresImmediateAttention: json['requiresImmediateAttention'] as bool?,
);

Map<String, dynamic> _$DiagnosisResultModelToJson(
  DiagnosisResultModel instance,
) => <String, dynamic>{
  'condition': instance.condition,
  'description': instance.description,
  'severity': instance.severity,
  'confidenceScore': instance.confidenceScore,
  'possibleCauses': instance.possibleCauses,
  'recommendations': instance.recommendations,
  'warningSymptoms': instance.warningSymptoms,
  'requiresImmediateAttention': instance.requiresImmediateAttention,
};

RecommendedDoctorModel _$RecommendedDoctorModelFromJson(
  Map<String, dynamic> json,
) => RecommendedDoctorModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  image: json['image'] as String?,
  specialtyName: json['specialtyName'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  consultationFee: json['consultationFee'] as String?,
  experience: json['experience'] as String?,
  isAvailable: json['isAvailable'] as bool?,
  nextAvailableSlot: json['nextAvailableSlot'] as String?,
);

Map<String, dynamic> _$RecommendedDoctorModelToJson(
  RecommendedDoctorModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': instance.image,
  'specialtyName': instance.specialtyName,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'consultationFee': instance.consultationFee,
  'experience': instance.experience,
  'isAvailable': instance.isAvailable,
  'nextAvailableSlot': instance.nextAvailableSlot,
};
