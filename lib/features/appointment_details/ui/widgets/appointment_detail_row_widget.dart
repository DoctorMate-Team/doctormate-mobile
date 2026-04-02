import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentDetailRowWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const AppointmentDetailRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 18.sp, color: iconColor),
        ),
        horizantialSpacing(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyles.font12GrayRegular,
              ),
              verticalSpacing(2),
              Text(
                value,
                style: TextStyles.font14DarkGreenMedium.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
