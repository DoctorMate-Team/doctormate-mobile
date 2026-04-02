import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/details/ui/widgets/tab_bar_widgets/reviews_customer_details_screen.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_cubit.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';

class ReviewsTabBarViewBody extends StatefulWidget {
  final String doctorId;

  const ReviewsTabBarViewBody({super.key, required this.doctorId});

  @override
  State<ReviewsTabBarViewBody> createState() => _ReviewsTabBarViewBodyState();
}

class _ReviewsTabBarViewBodyState extends State<ReviewsTabBarViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ReviewsCubit>().getDoctorReviews(widget.doctorId);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ReviewsCubit>().loadMoreReviews(widget.doctorId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsState>(
      buildWhen:
          (previous, current) => current.maybeWhen(
            getDoctorReviewsLoading: () => true,
            getDoctorReviewsSuccess: (_, __) => true,
            getDoctorReviewsError: (_) => true,
            loadMoreReviewsSuccess: (_, __) => true,
            orElse: () => false,
          ),
      builder: (context, state) {
        return state.maybeWhen(
          getDoctorReviewsLoading: () => _buildLoadingState(),
          getDoctorReviewsSuccess:
              (response, allReviews) =>
                  _buildSuccessState(response.totalItems, allReviews),
          loadMoreReviewsSuccess:
              (response, allReviews) =>
                  _buildSuccessState(response.totalItems, allReviews),
          getDoctorReviewsError: (error) => _buildErrorState(error),
          orElse: () => _buildLoadingState(),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        _buildHeader(count: 0, rating: 4.8),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemBuilder: (context, index) => _buildShimmerCard(),
            separatorBuilder: (context, index) => verticalSpacing(12),
            itemCount: 5,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState(int totalItems, List allReviews) {
    if (allReviews.isEmpty) {
      return _buildEmptyState();
    }

    final averageRating = _calculateAverageRating(allReviews);

    return Column(
      children: [
        _buildHeader(count: totalItems, rating: averageRating),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<ReviewsCubit>().getDoctorReviews(
                widget.doctorId,
                refresh: true,
              );
            },
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < allReviews.length) {
                  return ReviewsCustomerDetailsScreen(
                    review: allReviews[index],
                  );
                }
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              separatorBuilder: (context, index) => verticalSpacing(12),
              itemCount: allReviews.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String error) {
    return Column(
      children: [
        _buildHeader(count: 0, rating: 0),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: Colors.red[300],
                  ),
                  verticalSpacing(16),
                  Text(
                    'Failed to load reviews',
                    style: TextStyles.font16DarkGreenBold,
                  ),
                  verticalSpacing(8),
                  Text(
                    error,
                    style: TextStyles.font14GrayRegular,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpacing(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ReviewsCubit>().getDoctorReviews(
                        widget.doctorId,
                        refresh: true,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        _buildHeader(count: 0, rating: 0),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.rate_review_outlined,
                  size: 64.sp,
                  color: Colors.grey[400],
                ),
                verticalSpacing(16),
                Text('No reviews yet', style: TextStyles.font16DarkGreenBold),
                verticalSpacing(8),
                Text(
                  'Be the first to review this doctor',
                  style: TextStyles.font14GrayRegular,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader({required int count, required double rating}) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Reviews',
                style: TextStyles.font16DarkGreenBold.copyWith(
                  fontWeight: FontWeightHelper.bold,
                  fontSize: 18.sp,
                ),
              ),
              verticalSpacing(4),
              Row(
                children: [
                  Icon(Iconsax.star_1, color: ColorsManager.gold, size: 16.sp),
                  horizantialSpacing(4),
                  Text(
                    rating > 0
                        ? '${rating.toStringAsFixed(1)} out of 5'
                        : 'No rating yet',
                    style: TextStyles.font14GrayRegular,
                  ),
                ],
              ),
            ],
          ),
          if (count > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '$count ${count == 1 ? 'review' : 'reviews'}',
                style: TextStyles.font12DarkGreenRegular.copyWith(
                  color: ColorsManager.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 24.r, backgroundColor: Colors.white),
                horizantialSpacing(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16.h,
                        width: 120.w,
                        color: Colors.white,
                      ),
                      verticalSpacing(8),
                      Container(height: 14.h, width: 80.w, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpacing(12),
            Container(height: 14.h, color: Colors.white),
            verticalSpacing(8),
            Container(
              height: 14.h,
              width: double.infinity,
              color: Colors.white,
            ),
            verticalSpacing(8),
            Container(height: 14.h, width: 200.w, color: Colors.white),
          ],
        ),
      ),
    );
  }

  double _calculateAverageRating(List reviews) {
    if (reviews.isEmpty) return 0;
    final total = reviews.fold<double>(
      0.0,
      (sum, review) => sum + review.rating,
    );
    return total / reviews.length;
  }
}
