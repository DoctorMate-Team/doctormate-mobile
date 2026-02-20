import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchAppBar extends StatelessWidget {

  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Colors.white,
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Iconsax.arrow_left_2,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
            ),
          ),

          // Title
          Expanded(
            child: Center(
              child: Text(
                'Search Doctors',
                style: TextStyles.font18DarkGreenBold,
              ),
            ),
          ),

          // Placeholder for symmetry
          horizantialSpacing(40),
        ],
      ),
    );
  }
}
