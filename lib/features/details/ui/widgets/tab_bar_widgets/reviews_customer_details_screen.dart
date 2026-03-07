import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/app_images.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/reviews/data/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class ReviewsCustomerDetailsScreen extends StatelessWidget {
  final ReviewModel review;

  const ReviewsCustomerDetailsScreen({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              CircleAvatar(
                radius: 24.r,
                backgroundImage:
                    review.patientImage != null
                        ? CachedNetworkImageProvider(review.patientImage!)
                        : const AssetImage(AppImages.homeDoctorBanner)
                            as ImageProvider,
                backgroundColor: Colors.grey[200],
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.patientName,
                      style: TextStyles.font14DarkGreenMedium.copyWith(
                        fontWeight: FontWeightHelper.semiBold,
                        fontSize: 15.sp,
                      ),
                    ),
                    verticalSpacing(4),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: Icon(
                              index < review.rating
                                  ? Iconsax.star_1
                                  : Iconsax.star,
                              color:
                                  index < review.rating
                                      ? ColorsManager.gold
                                      : Colors.grey[300],
                              size: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                _formatDate(review.createdAt),
                style: TextStyles.font12GrayRegular,
              ),
            ],
          ),
          verticalSpacing(12),
          Text(
            review.comment,
            style: TextStyles.font14GrayRegular.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}
