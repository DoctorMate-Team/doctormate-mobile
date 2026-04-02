import 'package:json_annotation/json_annotation.dart';

part 'create_review_request.g.dart';

@JsonSerializable()
class CreateReviewRequest {
  final String appointmentId;
  final int rating;
  final String comment;

  CreateReviewRequest({
    required this.appointmentId,
    required this.rating,
    required this.comment,
  });

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateReviewRequestToJson(this);
}

@JsonSerializable()
class UpdateReviewRequest {
  final int rating;
  final String comment;

  UpdateReviewRequest({required this.rating, required this.comment});

  factory UpdateReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReviewRequestToJson(this);
}
