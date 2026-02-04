import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_medication_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PrescriptionMedicationsCard extends StatelessWidget {
  final PrescriptionDetailsResponse prescription;

  const PrescriptionMedicationsCard({super.key, required this.prescription});

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
                Iconsax.health,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              horizantialSpacing(8),
              Text(
                'Medications (${prescription.medications.length})',
                style: TextStyles.font16DarkGreenBold,
              ),
            ],
          ),
          verticalSpacing(16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: prescription.medications.length,
            separatorBuilder:
                (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Divider(color: Colors.grey.shade200, height: 1),
                ),
            itemBuilder: (context, index) {
              final medication = prescription.medications[index];
              return PrescriptionMedicationItem(
                medication: medication,
                number: index + 1,
              );
            },
          ),
        ],
      ),
    );
  }
}
