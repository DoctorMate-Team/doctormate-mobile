import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class PrescriptionValidityCard extends StatelessWidget {
  final PrescriptionDetailsResponse prescription;

  const PrescriptionValidityCard({super.key, required this.prescription});

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
                Iconsax.calendar_tick,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              horizantialSpacing(8),
              Text('Validity Period', style: TextStyles.font16DarkGreenBold),
            ],
          ),
          verticalSpacing(12),
          _buildInfoRow(
            Iconsax.calendar_1,
            'Prescribed Date',
            DateFormat('MMMM dd, yyyy').format(
              DateTime.parse(
                prescription.appointment?.scheduledStart ??
                    DateTime.now().toIso8601String(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16.sp, color: ColorsManager.gray),
        horizantialSpacing(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyles.font12GrayRegular),
              verticalSpacing(2),
              Text(value, style: TextStyles.font14DarkGreenMedium),
            ],
          ),
        ),
      ],
    );
  }
}
