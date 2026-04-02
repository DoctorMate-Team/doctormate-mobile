// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  id: json['id'] as String,
  doctorId: json['doctorId'] as String?,
  doctorName: json['doctorName'] as String?,
  patientId: json['patientId'] as String?,
  patientName: json['patientName'] as String,
  patientImage: json['patientImage'] as String?,
  appointmentId: json['appointmentId'] as String?,
  appointmentDate:
      json['appointmentDate'] == null
          ? null
          : DateTime.parse(json['appointmentDate'] as String),
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'patientId': instance.patientId,
      'patientName': instance.patientName,
      'patientImage': instance.patientImage,
      'appointmentId': instance.appointmentId,
      'appointmentDate': instance.appointmentDate?.toIso8601String(),
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
