// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_reviews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorReviewsResponse _$DoctorReviewsResponseFromJson(
  Map<String, dynamic> json,
) => DoctorReviewsResponse(
  data:
      (json['data'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  totalItems: (json['totalItems'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasPreviousPage: json['hasPreviousPage'] as bool,
  hasNextPage: json['hasNextPage'] as bool,
);

Map<String, dynamic> _$DoctorReviewsResponseToJson(
  DoctorReviewsResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'page': instance.page,
  'limit': instance.limit,
  'totalItems': instance.totalItems,
  'totalPages': instance.totalPages,
  'hasPreviousPage': instance.hasPreviousPage,
  'hasNextPage': instance.hasNextPage,
};
