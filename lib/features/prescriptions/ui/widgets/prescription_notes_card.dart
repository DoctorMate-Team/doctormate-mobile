import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PrescriptionNotesCard extends StatelessWidget {
  final PrescriptionDetailsResponse prescription;

  const PrescriptionNotesCard({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.message_text,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              horizantialSpacing(8),
              Text('Important Notes', style: TextStyles.font16DarkGreenBold),
            ],
          ),
          verticalSpacing(12),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.danger, size: 18.sp, color: Colors.amber.shade700),
                horizantialSpacing(8),
                Expanded(
                  child: Text(
                    prescription.notes!,
                    style: TextStyles.font14GrayRegular.copyWith(
                      height: 1.6,
                      color: Colors.amber.shade900,
                    ),
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
