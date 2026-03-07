import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final String id;
  @JsonKey(name: 'doctorId')
  final String? doctorId;
  @JsonKey(name: 'doctorName')
  final String? doctorName;
  @JsonKey(name: 'patientId')
  final String? patientId;
  @JsonKey(name: 'patientName')
  final String patientName;
  @JsonKey(name: 'patientImage')
  final String? patientImage;
  @JsonKey(name: 'appointmentId')
  final String? appointmentId;
  @JsonKey(name: 'appointmentDate')
  final DateTime? appointmentDate;
  final int rating;
  final String comment;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  ReviewModel({
    required this.id,
    this.doctorId,
    this.doctorName,
    this.patientId,
    required this.patientName,
    this.patientImage,
    this.appointmentId,
    this.appointmentDate,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
