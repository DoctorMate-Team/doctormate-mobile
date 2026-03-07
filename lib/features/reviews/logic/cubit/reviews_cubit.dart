import 'package:doctor_mate/features/reviews/data/models/create_review_request.dart';
import 'package:doctor_mate/features/reviews/data/models/review_model.dart';
import 'package:doctor_mate/features/reviews/data/repos/reviews_repository.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsRepository _reviewsRepository;

  ReviewsCubit(this._reviewsRepository) : super(const ReviewsState.initial());

  List<ReviewModel> _allReviews = [];
  int _currentPage = 1;
  bool _hasNextPage = false;

  void getDoctorReviews(String doctorId, {bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _allReviews = [];
    }

    emit(const ReviewsState.getDoctorReviewsLoading());

    final result = await _reviewsRepository.getDoctorReviews(
      doctorId,
      page: _currentPage,
      pageSize: 10,
    );

    result.when(
      success: (response) {
        _allReviews =
            refresh
                ? response.data.data
                : [..._allReviews, ...response.data.data];
        _hasNextPage = response.data.hasNextPage;
        emit(ReviewsState.getDoctorReviewsSuccess(response.data, _allReviews));
      },
      failure: (error) {
        emit(
          ReviewsState.getDoctorReviewsError(
            error.apiErrorModel.message ?? 'Failed to load reviews',
          ),
        );
      },
    );
  }

  void loadMoreReviews(String doctorId) async {
    if (!_hasNextPage) return;

    emit(const ReviewsState.loadMoreReviewsLoading());

    _currentPage++;

    final result = await _reviewsRepository.getDoctorReviews(
      doctorId,
      page: _currentPage,
      pageSize: 10,
    );

    result.when(
      success: (response) {
        _allReviews = [..._allReviews, ...response.data.data];
        _hasNextPage = response.data.hasNextPage;
        emit(ReviewsState.loadMoreReviewsSuccess(response.data, _allReviews));
      },
      failure: (error) {
        _currentPage--; // Revert page increment on error
        emit(
          ReviewsState.loadMoreReviewsError(
            error.apiErrorModel.message ?? 'Failed to load more reviews',
          ),
        );
      },
    );
  }

  void getMyReviewForAppointment(String appointmentId) async {
    emit(const ReviewsState.getMyReviewLoading());

    final result = await _reviewsRepository.getMyReviewForAppointment(
      appointmentId,
    );

    result.when(
      success: (review) {
        emit(ReviewsState.getMyReviewSuccess(review.data));
      },
      failure: (error) {
        // Review not found is not an error - user hasn't reviewed yet
        if (error.apiErrorModel.code == 404) {
          emit(const ReviewsState.getMyReviewSuccess(null));
        } else {
          emit(
            ReviewsState.getMyReviewError(
              error.apiErrorModel.message ?? 'Failed to load review',
            ),
          );
        }
      },
    );
  }

  void createReview(CreateReviewRequest request) async {
    emit(const ReviewsState.createReviewLoading());

    final result = await _reviewsRepository.createReview(request);

    result.when(
      success: (review) {
        emit(ReviewsState.createReviewSuccess(review.data));
      },
      failure: (error) {
        emit(
          ReviewsState.createReviewError(
            error.apiErrorModel.message ?? 'Failed to create review',
          ),
        );
      },
    );
  }

  void updateReview(String reviewId, UpdateReviewRequest request) async {
    emit(const ReviewsState.updateReviewLoading());

    final result = await _reviewsRepository.updateReview(reviewId, request);

    result.when(
      success: (review) {
        emit(ReviewsState.updateReviewSuccess(review.data));
      },
      failure: (error) {
        emit(
          ReviewsState.updateReviewError(
            error.apiErrorModel.message ?? 'Failed to update review',
          ),
        );
      },
    );
  }

  void deleteReview(String reviewId) async {
    emit(const ReviewsState.deleteReviewLoading());

    final result = await _reviewsRepository.deleteReview(reviewId);

    result.when(
      success: (message) {
        emit(ReviewsState.deleteReviewSuccess(message.data));
      },
      failure: (error) {
        emit(
          ReviewsState.deleteReviewError(
            error.apiErrorModel.message ?? 'Failed to delete review',
          ),
        );
      },
    );
  }

  void resetToInitial() {
    emit(const ReviewsState.initial());
  }
}
