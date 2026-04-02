import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MedicationItemWidget extends StatelessWidget {
  final String drugName;
  final String dosage;
  final String frequency;
  final String duration;
  final String instructions;

  const MedicationItemWidget({
    super.key,
    required this.drugName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.health,
                size: 20.sp,
                color: Colors.blue,
              ),
              horizantialSpacing(8),
              Expanded(
                child: Text(
                  drugName,
                  style: TextStyles.font16DarkGreenBold.copyWith(color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  dosage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeightHelper.bold,
                  ),
                ),
              ),
            ],
          ),
          verticalSpacing(8),
          Divider(height: 1, color: Colors.grey[300]),
          verticalSpacing(8),
          _MedicationDetailRow(
            icon: Iconsax.clock,
            label: 'Frequency',
            value: frequency,
          ),
          verticalSpacing(6),
          _MedicationDetailRow(
            icon: Iconsax.calendar,
            label: 'Duration',
            value: duration,
          ),
          verticalSpacing(6),
          _MedicationDetailRow(
            icon: Iconsax.info_circle,
            label: 'Instructions',
            value: instructions,
          ),
        ],
      ),
    );
  }
}

class _MedicationDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MedicationDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey),
        horizantialSpacing(6),
        Text(
          '$label: ',
          style: TextStyles.font12GrayRegular.copyWith(
            fontWeight: FontWeightHelper.medium,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyles.font12GrayRegular,
          ),
        ),
      ],
    );
  }
}
