import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/reviews/data/models/create_review_request.dart';
import 'package:doctor_mate/features/reviews/data/models/doctor_reviews_response.dart';
import 'package:doctor_mate/features/reviews/data/models/review_model.dart';
import 'package:retrofit/retrofit.dart';

part 'reviews_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ReviewsApiService {
  factory ReviewsApiService(Dio dio, {String baseUrl}) = _ReviewsApiService;

  @POST(ApiConstants.doctorReviews)
  Future<DoctorMateResponse<ReviewModel>> createReview(
    @Body() CreateReviewRequest request,
  );

  @GET('${ApiConstants.doctorReviews}/doctor/{doctorId}')
  Future<DoctorMateResponse<DoctorReviewsResponse>> getDoctorReviews(
    @Path('doctorId') String doctorId, {
    @Query('page') int page = 1,
    @Query('pageSize') int pageSize = 10,
  });

  @GET('${ApiConstants.doctorReviews}/appointment/{appointmentId}/my-review')
  Future<DoctorMateResponse<ReviewModel>> getMyReviewForAppointment(
    @Path('appointmentId') String appointmentId,
  );

  @PUT('${ApiConstants.doctorReviews}/{reviewId}')
  Future<DoctorMateResponse<ReviewModel>> updateReview(
    @Path('reviewId') String reviewId,
    @Body() UpdateReviewRequest request,
  );

  @DELETE('${ApiConstants.doctorReviews}/{reviewId}')
  Future<DoctorMateResponse<String>> deleteReview(
    @Path('reviewId') String reviewId,
  );
}
