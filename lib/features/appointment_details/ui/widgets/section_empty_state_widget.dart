import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionEmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const SectionEmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48.sp,
            color: Colors.grey[300],
          ),
          verticalSpacing(12),
          Text(
            title,
            style: TextStyles.font14DarkGreenMedium.copyWith(color: Colors.black),
          ),
          verticalSpacing(4),
          Text(
            message,
            style: TextStyles.font12GrayRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
