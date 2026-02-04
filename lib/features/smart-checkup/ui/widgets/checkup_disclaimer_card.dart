import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CheckupDisclaimerCard extends StatelessWidget {
  const CheckupDisclaimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.amber.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.danger, color: Colors.amber.shade700, size: 20.sp),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Important Notice',
                  style: TextStyles.font14GreenSemiBold.copyWith(
                    color: Colors.amber.shade900,
                  ),
                ),
                verticalSpacing(4),
                Text(
                  'This AI analysis is for informational purposes only and does not replace professional medical advice. Please consult a qualified healthcare provider for accurate diagnosis and treatment.',
                  style: TextStyles.font12DarkGreenRegular.copyWith(
                    color: Colors.amber.shade800,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
