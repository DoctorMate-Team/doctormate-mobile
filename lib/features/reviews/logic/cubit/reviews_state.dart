import 'package:doctor_mate/features/reviews/data/models/doctor_reviews_response.dart';
import 'package:doctor_mate/features/reviews/data/models/review_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reviews_state.freezed.dart';

@freezed
class ReviewsState with _$ReviewsState {
  const factory ReviewsState.initial() = _Initial;

  // Get doctor reviews
  const factory ReviewsState.getDoctorReviewsLoading() =
      _GetDoctorReviewsLoading;
  const factory ReviewsState.getDoctorReviewsSuccess(
    DoctorReviewsResponse response,
    List<ReviewModel> allReviews,
  ) = _GetDoctorReviewsSuccess;
  const factory ReviewsState.getDoctorReviewsError(String error) =
      _GetDoctorReviewsError;

  // Load more reviews
  const factory ReviewsState.loadMoreReviewsLoading() = _LoadMoreReviewsLoading;
  const factory ReviewsState.loadMoreReviewsSuccess(
    DoctorReviewsResponse response,
    List<ReviewModel> allReviews,
  ) = _LoadMoreReviewsSuccess;
  const factory ReviewsState.loadMoreReviewsError(String error) =
      _LoadMoreReviewsError;

  // Get my review for appointment
  const factory ReviewsState.getMyReviewLoading() = _GetMyReviewLoading;
  const factory ReviewsState.getMyReviewSuccess(ReviewModel? review) =
      _GetMyReviewSuccess;
  const factory ReviewsState.getMyReviewError(String error) = _GetMyReviewError;

  // Create review
  const factory ReviewsState.createReviewLoading() = _CreateReviewLoading;
  const factory ReviewsState.createReviewSuccess(ReviewModel review) =
      _CreateReviewSuccess;
  const factory ReviewsState.createReviewError(String error) =
      _CreateReviewError;

  // Update review
  const factory ReviewsState.updateReviewLoading() = _UpdateReviewLoading;
  const factory ReviewsState.updateReviewSuccess(ReviewModel review) =
      _UpdateReviewSuccess;
  const factory ReviewsState.updateReviewError(String error) =
      _UpdateReviewError;

  // Delete review
  const factory ReviewsState.deleteReviewLoading() = _DeleteReviewLoading;
  const factory ReviewsState.deleteReviewSuccess(String message) =
      _DeleteReviewSuccess;
  const factory ReviewsState.deleteReviewError(String error) =
      _DeleteReviewError;
}
