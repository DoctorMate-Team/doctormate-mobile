import 'package:json_annotation/json_annotation.dart';

part 'symptom_check_response.g.dart';

@JsonSerializable()
class SymptomCheckResponse {
  final String? id;
  final String? patientId;
  final String? patientName;
  final String? checkType; // 'symptom' or 'skin'
  final String? symptoms;
  final String? imageUrl;
  final DiagnosisResultModel? diagnosis;
  final List<RecommendedDoctorModel>? recommendedDoctors;
  final DateTime? createdAt;

  SymptomCheckResponse({
    this.id,
    this.patientId,
    this.patientName,
    this.checkType,
    this.symptoms,
    this.imageUrl,
    this.diagnosis,
    this.recommendedDoctors,
    this.createdAt,
  });

  factory SymptomCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$SymptomCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SymptomCheckResponseToJson(this);
}

@JsonSerializable()
class DiagnosisResultModel {
  final String? condition;
  final String? description;
  final String? severity; // 'mild', 'moderate', 'severe'
  final double? confidenceScore;
  final List<String>? possibleCauses;
  final List<String>? recommendations;
  final List<String>? warningSymptoms;
  final bool? requiresImmediateAttention;

  DiagnosisResultModel({
    this.condition,
    this.description,
    this.severity,
    this.confidenceScore,
    this.possibleCauses,
    this.recommendations,
    this.warningSymptoms,
    this.requiresImmediateAttention,
  });

  factory DiagnosisResultModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisResultModelToJson(this);
}

@JsonSerializable()
class RecommendedDoctorModel {
  final String? id;
  final String? name;
  final String? image;
  final String? specialtyName;
  final double? rating;
  final int? reviewCount;
  final String? consultationFee;
  final String? experience;
  final bool? isAvailable;
  final String? nextAvailableSlot;

  RecommendedDoctorModel({
    this.id,
    this.name,
    this.image,
    this.specialtyName,
    this.rating,
    this.reviewCount,
    this.consultationFee,
    this.experience,
    this.isAvailable,
    this.nextAvailableSlot,
  });

  factory RecommendedDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendedDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedDoctorModelToJson(this);
}
