import 'package:doctor_mate/core/helper/app_images.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ModernAppBar extends StatelessWidget {
  const ModernAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Simplified Profile Section
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorsManager.primaryColor.withOpacity(0.3),
              width: 2.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage(AppImages.onBoarding1),
              fit: BoxFit.cover,
            ),
          ),
        ),
        horizantialSpacing(12),

        // Clean Greeting Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome back,", style: TextStyles.font12GrayRegular),
              verticalSpacing(2),
              Text('Mohammad Reda', style: TextStyles.font18DarkGreySemiBold),
            ],
          ),
        ),

        // Minimalist Action Buttons
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Icon(
            Iconsax.notification,
            color: Colors.grey.shade600,
            size: 20.sp,
          ),
        ),
        horizantialSpacing(8),
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Icon(
            Iconsax.setting_2,
            color: Colors.grey.shade600,
            size: 20.sp,
          ),
        ),
      ],
    );
  }
}
