import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/reviews/data/models/review_model.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_cubit.dart';
import 'package:doctor_mate/features/reviews/ui/widgets/add_review_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReviewSectionCard extends StatelessWidget {
  final String appointmentId;
  final ReviewModel? myReview;
  final VoidCallback onReviewSubmitted;

  const ReviewSectionCard({
    super.key,
    required this.appointmentId,
    this.myReview,
    required this.onReviewSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Iconsax.star_1,
                  color: ColorsManager.primaryColor,
                  size: 24.sp,
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myReview != null ? 'Your Review' : 'Rate Your Experience',
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    verticalSpacing(4),
                    Text(
                      myReview != null
                          ? 'You rated this appointment ${myReview!.rating} stars'
                          : 'Share your experience with this doctor',
                      style: TextStyles.font12GrayRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (myReview != null) ...[
            verticalSpacing(16),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Icon(
                          index < myReview!.rating
                              ? Iconsax.star_1
                              : Iconsax.star,
                          color:
                              index < myReview!.rating
                                  ? ColorsManager.gold
                                  : Colors.grey[300],
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  verticalSpacing(8),
                  Text(
                    myReview!.comment,
                    style: TextStyles.font14GrayRegular,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
          verticalSpacing(16),
          CustomMaterialButton(
            textButton: myReview != null ? 'Edit Review' : 'Write a Review',
            onPressed: () => _showReviewDialog(context),
            backgroundColor:
                myReview != null
                    ? Colors.grey.shade100
                    : ColorsManager.primaryColor,
            textColor: myReview != null ? ColorsManager.darkBlue : Colors.white,
            icon: myReview != null ? Iconsax.edit : Iconsax.star_1,
          ),
        ],
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => BlocProvider.value(
            value: context.read<ReviewsCubit>(),
            child: AddReviewDialog(
              appointmentId: appointmentId,
              existingReview: myReview,
            ),
          ),
    ).then((result) {
      if (result == true) {
        onReviewSubmitted();
      }
    });
  }
}
