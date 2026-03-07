import 'package:doctor_mate/features/reviews/data/models/review_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_reviews_response.g.dart';

@JsonSerializable()
class DoctorReviewsResponse {
  final List<ReviewModel> data;
  final int page;
  final int limit;
  @JsonKey(name: 'totalItems')
  final int totalItems;
  @JsonKey(name: 'totalPages')
  final int totalPages;
  @JsonKey(name: 'hasPreviousPage')
  final bool hasPreviousPage;
  @JsonKey(name: 'hasNextPage')
  final bool hasNextPage;

  DoctorReviewsResponse({
    required this.data,
    required this.page,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory DoctorReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorReviewsResponseToJson(this);
}
