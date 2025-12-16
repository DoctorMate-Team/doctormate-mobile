import 'package:json_annotation/json_annotation.dart';

part 'prescription_details_response.g.dart';

@JsonSerializable()
class PrescriptionDetailsResponse {
  final String id;
  final String diagnosisId;
  final String patientId;
  final String patientName;
  final String? patientImage;
  final String doctorId;
  final String doctorName;
  final String? doctorImage;
  final String specialtyName;
  final String prescribedDate;
  final String? expiryDate;
  final String status;
  final String? notes;
  final List<PrescriptionMedicationModel> medications;

  PrescriptionDetailsResponse({
    required this.id,
    required this.diagnosisId,
    required this.patientId,
    required this.patientName,
    this.patientImage,
    required this.doctorId,
    required this.doctorName,
    this.doctorImage,
    required this.specialtyName,
    required this.prescribedDate,
    this.expiryDate,
    required this.status,
    this.notes,
    required this.medications,
  });

  factory PrescriptionDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionDetailsResponseToJson(this);
}

@JsonSerializable()
class PrescriptionMedicationModel {
  final String drugName;
  final String? dosage;
  final String? instructions;
  final int? durationDays;

  PrescriptionMedicationModel({
    required this.drugName,
    this.dosage,
    this.instructions,
    this.durationDays,
  });

  factory PrescriptionMedicationModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionMedicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionMedicationModelToJson(this);
}
