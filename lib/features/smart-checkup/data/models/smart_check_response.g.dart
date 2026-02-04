// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartCheckResponse _$SmartCheckResponseFromJson(
  Map<String, dynamic> json,
) => SmartCheckResponse(
  possibleDiagnosis: json['possible_diagnosis'] as String,
  confidence: (json['confidence'] as num).toDouble(),
  severity: json['severity'] as String,
  description: json['description'] as String,
  recommendations:
      (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  emergencyCare: json['emergency_care'] as String,
  specialty: SpecialtyModel.fromJson(json['specialty'] as Map<String, dynamic>),
  recommendedDoctors:
      (json['recommended_doctors'] as List<dynamic>)
          .map(
            (e) => RecommendedDoctorModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  additionalInfo:
      json['additional_info'] == null
          ? null
          : AdditionalInfoModel.fromJson(
            json['additional_info'] as Map<String, dynamic>,
          ),
  disclaimer: json['disclaimer'] as String,
);

Map<String, dynamic> _$SmartCheckResponseToJson(SmartCheckResponse instance) =>
    <String, dynamic>{
      'possible_diagnosis': instance.possibleDiagnosis,
      'confidence': instance.confidence,
      'severity': instance.severity,
      'description': instance.description,
      'recommendations': instance.recommendations,
      'emergency_care': instance.emergencyCare,
      'specialty': instance.specialty,
      'recommended_doctors': instance.recommendedDoctors,
      'additional_info': instance.additionalInfo,
      'disclaimer': instance.disclaimer,
    };

SpecialtyModel _$SpecialtyModelFromJson(Map<String, dynamic> json) =>
    SpecialtyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$SpecialtyModelToJson(SpecialtyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };

RecommendedDoctorModel _$RecommendedDoctorModelFromJson(
  Map<String, dynamic> json,
) => RecommendedDoctorModel(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  imageUrl: json['imageUrl'] as String,
  consultationFee: (json['consultationFee'] as num).toDouble(),
  address: json['address'] as String,
  workingTime: json['workingTime'] as String,
  qualifications: json['qualifications'] as String,
);

Map<String, dynamic> _$RecommendedDoctorModelToJson(
  RecommendedDoctorModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'imageUrl': instance.imageUrl,
  'consultationFee': instance.consultationFee,
  'address': instance.address,
  'workingTime': instance.workingTime,
  'qualifications': instance.qualifications,
};

AdditionalInfoModel _$AdditionalInfoModelFromJson(Map<String, dynamic> json) =>
    AdditionalInfoModel(
      diagnosisCode: json['diagnosis_code'] as String,
      riskFactors:
          (json['risk_factors'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      symptoms:
          (json['symptoms'] as List<dynamic>).map((e) => e as String).toList(),
      prognosis: json['prognosis'] as String,
      treatmentOptions:
          (json['treatment_options'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      allProbabilities: (json['all_probabilities'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$AdditionalInfoModelToJson(
  AdditionalInfoModel instance,
) => <String, dynamic>{
  'diagnosis_code': instance.diagnosisCode,
  'risk_factors': instance.riskFactors,
  'symptoms': instance.symptoms,
  'prognosis': instance.prognosis,
  'treatment_options': instance.treatmentOptions,
  'all_probabilities': instance.allProbabilities,
};
