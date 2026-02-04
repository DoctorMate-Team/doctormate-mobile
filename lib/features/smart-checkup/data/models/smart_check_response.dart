import 'package:json_annotation/json_annotation.dart';

part 'smart_check_response.g.dart';

@JsonSerializable()
class SmartCheckResponse {
  @JsonKey(name: 'possible_diagnosis')
  final String possibleDiagnosis;
  final double confidence;
  final String severity;
  final String description;
  final List<String> recommendations;
  @JsonKey(name: 'emergency_care')
  final String emergencyCare;
  final SpecialtyModel specialty;
  @JsonKey(name: 'recommended_doctors')
  final List<RecommendedDoctorModel> recommendedDoctors;
  @JsonKey(name: 'additional_info')
  final AdditionalInfoModel? additionalInfo;
  final String disclaimer;

  SmartCheckResponse({
    required this.possibleDiagnosis,
    required this.confidence,
    required this.severity,
    required this.description,
    required this.recommendations,
    required this.emergencyCare,
    required this.specialty,
    required this.recommendedDoctors,
    this.additionalInfo,
    required this.disclaimer,
  });

  factory SmartCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$SmartCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SmartCheckResponseToJson(this);
}

@JsonSerializable()
class SpecialtyModel {
  final String id;
  final String name;
  final String description;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  SpecialtyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialtyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialtyModelToJson(this);
}

@JsonSerializable()
class RecommendedDoctorModel {
  final String id;
  @JsonKey(name: 'fullName')
  final String fullName;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  @JsonKey(name: 'consultationFee')
  final double consultationFee;
  final String address;
  @JsonKey(name: 'workingTime')
  final String workingTime;
  final String qualifications;

  RecommendedDoctorModel({
    required this.id,
    required this.fullName,
    required this.imageUrl,
    required this.consultationFee,
    required this.address,
    required this.workingTime,
    required this.qualifications,
  });

  factory RecommendedDoctorModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendedDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendedDoctorModelToJson(this);
}

@JsonSerializable()
class AdditionalInfoModel {
  @JsonKey(name: 'diagnosis_code')
  final String diagnosisCode;
  @JsonKey(name: 'risk_factors')
  final List<String> riskFactors;
  final List<String> symptoms;
  final String prognosis;
  @JsonKey(name: 'treatment_options')
  final List<String> treatmentOptions;
  @JsonKey(name: 'all_probabilities')
  final Map<String, double> allProbabilities;

  AdditionalInfoModel({
    required this.diagnosisCode,
    required this.riskFactors,
    required this.symptoms,
    required this.prognosis,
    required this.treatmentOptions,
    required this.allProbabilities,
  });

  factory AdditionalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoModelToJson(this);
}
/*
{
    "code": 200,
    "message": "Skin lesion analysis completed successfully",
    "data": {
        "possible_diagnosis": "Melanoma",
        "confidence": 49,
        "severity": "Severe",
        "description": "Melanoma is the most serious type of skin cancer, developing from melanocytes (pigment-producing cells). It can spread rapidly to other parts of the body if not detected early. Early detection and treatment are critical.",
        "recommendations": [
            "URGENT: Consult a dermatologist immediately for evaluation",
            "Biopsy and staging will determine treatment",
            "May require surgical excision with wide margins",
            "Lymph node evaluation may be necessary",
            "Regular full-body skin examinations",
            "Genetic counseling if family history present"
        ],
        "emergency_care": "Seek immediate medical attention. Early diagnosis dramatically improves survival rates. Do not delay consultation with a dermatologist or oncologist.",
        "specialty": {
            "id": "b2222222-b2b2-b2b2-b2b2-b2b2b2b2b2b2",
            "name": "Dermatology",
            "description": "Specializes in the diagnosis and treatment of skin disorders.",
            "imageUrl": "https://example.com/images/derma.png"
        },
        "recommended_doctors": [
            {
                "id": "f90e45ea-2fd3-40b2-e3f7-08de18aae672",
                "fullName": "yasser Ibrahime",
                "imageUrl": "//Default image",
                "consultationFee": 10000.0,
                "address": "Alex",
                "workingTime": "06:00 - 12:00",
                "qualifications": "MBBS, MD - Internal Medicine"
            },
            {
                "id": "05236058-b044-44b3-f148-08de18e69c37",
                "fullName": "Ahmed Hassan Ahmed",
                "imageUrl": "https://res.cloudinary.com/dukkhnflu/image/upload/v1761962147/doctormate/users/da6juevpg9ofv5mzrdm9.jpg",
                "consultationFee": 250.0,
                "address": "7 Tahrir Street, Giza",
                "workingTime": "09:00 - 05:00",
                "qualifications": "Bachelor of Medicine and Surgery - Cairo University"
            },
            {
                "id": "f6986b3b-5810-4f94-99c9-08de256c9f88",
                "fullName": "Sawsan Ibrahime",
                "imageUrl": "//Default image",
                "consultationFee": 250.0,
                "address": "Cairo",
                "workingTime": "09:00 - 17:00",
                "qualifications": "MD, PhD in Cardiology"
            }
        ],
        "additional_info": {
            "diagnosis_code": "mel",
            "risk_factors": [
                "UV radiation exposure",
                "History of sunburns, especially in childhood",
                "Fair skin, light hair, light eyes",
                "Many moles or atypical moles",
                "Family history of melanoma",
                "Weakened immune system",
                "Age (risk increases with age)"
            ],
            "symptoms": [
                "Asymmetric mole or lesion",
                "Border irregularity",
                "Color variation (multiple colors)",
                "Diameter larger than 6mm",
                "Evolving (changing in size, shape, or color)",
                "New mole appearing after age 30",
                "Itching, bleeding, or crusting"
            ],
            "prognosis": "Highly dependent on stage at diagnosis. Early-stage melanoma has excellent cure rates (>95%). Advanced melanoma requires aggressive treatment and has poorer outcomes.",
            "treatment_options": [
                "Surgical excision with margins",
                "Sentinel lymph node biopsy",
                "Immunotherapy",
                "Targeted therapy",
                "Radiation therapy",
                "Chemotherapy (for advanced cases)"
            ],
            "all_probabilities": {
                "akiec": 1.5,
                "bcc": 12.9,
                "bkl": 0.5,
                "df": 0.1,
                "mel": 49.0,
                "nv": 34.8,
                "vasc": 1.2
            }
        },
        "disclaimer": "This is an AI-generated assessment and not a substitute for professional medical advice. Please consult a dermatologist for proper diagnosis and treatment."
    }
}
*/