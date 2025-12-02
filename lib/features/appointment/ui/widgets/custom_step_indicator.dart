import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const CustomStepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorsManager.lightGray.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isEven) {
            final stepIndex = index ~/ 2;
            final isCompleted = stepIndex < currentStep;
            final isCurrent = stepIndex == currentStep;

            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      gradient:
                          isCompleted || isCurrent
                              ? LinearGradient(
                                colors: [
                                  ColorsManager.primaryColor,
                                  ColorsManager.green,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                              : null,
                      color:
                          isCompleted || isCurrent
                              ? null
                              : ColorsManager.moreLighterGray,
                      shape: BoxShape.circle,
                      boxShadow:
                          isCompleted || isCurrent
                              ? [
                                BoxShadow(
                                  color: ColorsManager.primaryColor.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                              : null,
                    ),
                    child: Center(
                      child:
                          isCompleted
                              ? Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 20.sp,
                              )
                              : Text(
                                '${stepIndex + 1}',
                                style: TextStyles.font14GreenSemiBold.copyWith(
                                  color:
                                      isCurrent
                                          ? Colors.white
                                          : ColorsManager.lightGray,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    steps[stepIndex],
                    style: TextStyles.font11GrayRegular.copyWith(
                      color:
                          isCurrent || isCompleted
                              ? ColorsManager.darkBlue
                              : ColorsManager.lightGray,
                      fontWeight: isCurrent ? FontWeight.w600 : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            final stepIndex = index ~/ 2;
            final isCompleted = stepIndex < currentStep;

            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 3.h,
                    margin: EdgeInsets.only(bottom: 28.h),
                    decoration: BoxDecoration(
                      gradient:
                          isCompleted
                              ? LinearGradient(
                                colors: [
                                  ColorsManager.primaryColor,
                                  ColorsManager.green,
                                ],
                              )
                              : null,
                      color: isCompleted ? null : ColorsManager.moreLighterGray,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
