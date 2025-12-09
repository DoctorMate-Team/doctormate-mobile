import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeAppointmentScreen extends StatelessWidget {
  final bool isSelected;
  final String time;
  final VoidCallback onTap;
  final bool isPastTime;

  const TimeAppointmentScreen({
    super.key,
    required this.isSelected,
    required this.time,
    required this.onTap,
    this.isPastTime = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPastTime ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          gradient:
              isSelected && !isPastTime
                  ? LinearGradient(
                    colors: [ColorsManager.primaryColor, ColorsManager.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color:
              isSelected && !isPastTime
                  ? null
                  : isPastTime
                  ? ColorsManager.lighterGray.withOpacity(0.5)
                  : ColorsManager.moreLighterGray,
          border: Border.all(
            color:
                isSelected && !isPastTime
                    ? Colors.transparent
                    : isPastTime
                    ? ColorsManager.lightGray.withOpacity(0.3)
                    : Colors.transparent,
            width: 1.5,
          ),
          boxShadow:
              isSelected && !isPastTime
                  ? [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected && !isPastTime)
              Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
            Text(
              time,
              style: TextStyles.font14GreenSemiBold.copyWith(
                color:
                    isSelected && !isPastTime
                        ? Colors.white
                        : isPastTime
                        ? ColorsManager.lightGray.withOpacity(0.6)
                        : ColorsManager.darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
