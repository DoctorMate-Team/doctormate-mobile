import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SymptomInputCard extends StatelessWidget {
  final TextEditingController controller;

  const SymptomInputCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Describe Your Symptoms', style: TextStyles.font16DarkGreenBold),
        verticalSpacing(12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.note_text,
                      color: ColorsManager.primaryColor,
                      size: 20.sp,
                    ),
                    horizantialSpacing(8),
                    Text(
                      'Tell us what you\'re experiencing',
                      style: TextStyles.font14DarkGreenMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: TextField(
                  controller: controller,
                  maxLines: 6,
                  style: TextStyles.font14DarkGreenMedium,
                  decoration: InputDecoration(
                    hintText:
                        'E.g., I have a headache, fever, and sore throat for the past 2 days...',
                    hintStyle: TextStyles.font14DarkGreenMedium.copyWith(
                      color: Colors.grey.shade400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpacing(12),
        _buildQuickSymptoms(context),
      ],
    );
  }

  Widget _buildQuickSymptoms(BuildContext context) {
    final quickSymptoms = [
      'Headache',
      'Fever',
      'Cough',
      'Fatigue',
      'Nausea',
      'Dizziness',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Add',
          style: TextStyles.font14DarkGreenMedium.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        verticalSpacing(8),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children:
              quickSymptoms.map((symptom) {
                return GestureDetector(
                  onTap: () {
                    final currentText = controller.text;
                    if (currentText.isEmpty) {
                      controller.text = symptom;
                    } else {
                      controller.text = '$currentText, $symptom';
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: ColorsManager.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.add_circle,
                          color: ColorsManager.primaryColor,
                          size: 16.sp,
                        ),
                        horizantialSpacing(4),
                        Text(
                          symptom,
                          style: TextStyles.font12DarkGreenSemiBold.copyWith(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
