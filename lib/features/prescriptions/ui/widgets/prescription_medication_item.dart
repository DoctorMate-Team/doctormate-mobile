import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PrescriptionMedicationItem extends StatelessWidget {
  final PrescriptionMedicationModel medication;
  final int number;

  const PrescriptionMedicationItem({
    super.key,
    required this.medication,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: TextStyles.font14WhiteRegular.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.drugName,
                      style: TextStyles.font16DarkGreenBold,
                    ),
                    verticalSpacing(4),
                    Text(
                      'Dosage: ${medication.dosage}',
                      style: TextStyles.font14GrayRegular.copyWith(
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Iconsax.info_circle, size: 16.sp, color: ColorsManager.gray),
              horizantialSpacing(8),
              Expanded(
                child: Text(
                  medication.instructions,
                  style: TextStyles.font14GrayRegular.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
          verticalSpacing(8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.calendar,
                  size: 14.sp,
                  color: Colors.green.shade700,
                ),
                horizantialSpacing(4),
                Text(
                  'Duration: ${medication.durationDays} days',
                  style: TextStyles.font12GrayRegular.copyWith(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
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
