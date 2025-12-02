import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePickerAppointmentScreen extends StatelessWidget {
  const DatePickerAppointmentScreen({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('EEE').format(date);
    final dayNumber = date.day.toString();
    final monthName = DateFormat('MMM').format(date);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient:
              isSelected
                  ? LinearGradient(
                    colors: [ColorsManager.primaryColor, ColorsManager.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color: isSelected ? null : ColorsManager.moreLighterGray,
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: TextStyles.font12GreenSemiBold.copyWith(
                color: isSelected ? Colors.white : ColorsManager.lightGray,
                fontSize: 11.sp,
              ),
            ),
            verticalSpacing(4),
            Text(
              dayNumber,
              style: TextStyles.font18DarkGreenBold.copyWith(
                color: isSelected ? Colors.white : ColorsManager.darkBlue,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpacing(2),
            Text(
              monthName,
              style: TextStyles.font12GreenSemiBold.copyWith(
                color:
                    isSelected
                        ? Colors.white.withOpacity(0.9)
                        : ColorsManager.lightGray,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
