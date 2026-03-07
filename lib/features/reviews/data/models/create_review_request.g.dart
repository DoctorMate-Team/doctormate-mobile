// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReviewRequest _$CreateReviewRequestFromJson(Map<String, dynamic> json) =>
    CreateReviewRequest(
      appointmentId: json['appointmentId'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$CreateReviewRequestToJson(
  CreateReviewRequest instance,
) => <String, dynamic>{
  'appointmentId': instance.appointmentId,
  'rating': instance.rating,
  'comment': instance.comment,
};

UpdateReviewRequest _$UpdateReviewRequestFromJson(Map<String, dynamic> json) =>
    UpdateReviewRequest(
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$UpdateReviewRequestToJson(
  UpdateReviewRequest instance,
) => <String, dynamic>{'rating': instance.rating, 'comment': instance.comment};
