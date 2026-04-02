import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationInfoCard extends StatelessWidget {
  final String message;

  const NotificationInfoCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.info_circle,
            color: ColorsManager.primaryColor,
            size: 20.sp,
          ),
          horizantialSpacing(12),
          Expanded(child: Text(message, style: TextStyles.font12GrayRegular)),
        ],
      ),
    );
  }
}
