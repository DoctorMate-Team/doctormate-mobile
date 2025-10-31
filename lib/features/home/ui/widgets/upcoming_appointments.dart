import 'package:doctor_mate/core/helper/app_images.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.primaryColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: const DecorationImage(
                    image: AssetImage(AppImages.homeDoctorBanner),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizantialSpacing(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Eden Hazard',
                      style: TextStyles.font18DarkGreenBold.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    verticalSpacing(4),
                    Text(
                      'Orthopedic Surgeon',
                      style: TextStyles.font14GrayRegular,
                    ),
                    verticalSpacing(8),
                    Row(
                      children: [
                        Icon(
                          Iconsax.calendar,
                          size: 16.sp,
                          color: ColorsManager.primaryColor,
                        ),
                        horizantialSpacing(4),
                        Text(
                          'Today, 7:30 PM',
                          style: TextStyles.font14DarkGreenMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Confirmed',
                  style: TextStyles.font12DarkGreenSemiBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
