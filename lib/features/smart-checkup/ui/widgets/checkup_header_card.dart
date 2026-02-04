import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CheckupHeaderCard extends StatelessWidget {
  const CheckupHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEA4335), Color(0xFFD32F2F)],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEA4335).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Iconsax.heart_add, color: Colors.white, size: 28.sp),
        ),
        verticalSpacing(16),
        Text('AI-Powered Health Check', style: TextStyles.font20GreenBold),
        verticalSpacing(8),
        Text(
          'Describe your symptoms or upload a skin image for instant AI analysis and doctor recommendations',
          style: TextStyles.font14DarkGreenMedium.copyWith(
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
