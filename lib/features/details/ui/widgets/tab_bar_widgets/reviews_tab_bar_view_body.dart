import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/details/ui/widgets/tab_bar_widgets/reviews_customer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReviewsTabBarViewBody extends StatelessWidget {
  const ReviewsTabBarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Reviews Header
        Padding(
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
                      Icon(
                        Iconsax.star_1,
                        color: ColorsManager.gold,
                        size: 16.sp,
                      ),
                      horizantialSpacing(4),
                      Text('4.8 out of 5', style: TextStyles.font14GrayRegular),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '4,279 reviews',
                  style: TextStyles.font12DarkGreenRegular.copyWith(
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Reviews List
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const BouncingScrollPhysics(),
            itemBuilder:
                (context, index) => const ReviewsCustomerDetailsScreen(),
            separatorBuilder: (context, index) => verticalSpacing(12),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
