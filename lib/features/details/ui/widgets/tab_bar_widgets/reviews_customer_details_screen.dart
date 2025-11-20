import 'package:doctor_mate/core/helper/app_images.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReviewsCustomerDetailsScreen extends StatelessWidget {
  const ReviewsCustomerDetailsScreen({super.key});

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
                backgroundImage: const AssetImage(AppImages.homeDoctorBanner),
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenny Watson',
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
                              Iconsax.star_1,
                              color: ColorsManager.gold,
                              size: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text('2 days ago', style: TextStyles.font12GrayRegular),
            ],
          ),
          verticalSpacing(12),
          Text(
            'As someone who lives in a remote area with limited access to healthcare, this telemedicine app has been a game changer for me. I can easily schedule virtual appointments with doctors and get the care I need without having to travel long distances.',
            style: TextStyles.font14GrayRegular.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
