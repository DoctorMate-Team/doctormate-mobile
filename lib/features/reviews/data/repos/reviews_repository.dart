import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/reviews/data/apis/reviews_api_service.dart';
import 'package:doctor_mate/features/reviews/data/models/create_review_request.dart';
import 'package:doctor_mate/features/reviews/data/models/doctor_reviews_response.dart';
import 'package:doctor_mate/features/reviews/data/models/review_model.dart';

class ReviewsRepository {
  final ReviewsApiService _reviewsApiService;

  ReviewsRepository(this._reviewsApiService);

  Future<ApiResult<DoctorMateResponse<ReviewModel>>> createReview(
    CreateReviewRequest request,
  ) async {
    try {
      final response = await _reviewsApiService.createReview(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DoctorMateResponse<DoctorReviewsResponse>>> getDoctorReviews(
    String doctorId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _reviewsApiService.getDoctorReviews(
        doctorId,
        page: page,
        pageSize: pageSize,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DoctorMateResponse<ReviewModel>>> getMyReviewForAppointment(
    String appointmentId,
  ) async {
    try {
      final response = await _reviewsApiService.getMyReviewForAppointment(
        appointmentId,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DoctorMateResponse<ReviewModel>>> updateReview(
    String reviewId,
    UpdateReviewRequest request,
  ) async {
    try {
      final response = await _reviewsApiService.updateReview(reviewId, request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DoctorMateResponse<String>>> deleteReview(
    String reviewId,
  ) async {
    try {
      final response = await _reviewsApiService.deleteReview(reviewId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
