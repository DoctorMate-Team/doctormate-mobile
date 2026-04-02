import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class DiagnosisDetailsCard extends StatelessWidget {
  final DiagnosisModel diagnosis;

  const DiagnosisDetailsCard({super.key, required this.diagnosis});

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
                Iconsax.document_text,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
              horizantialSpacing(8),
              Text(
                'Clinical Description',
                style: TextStyles.font16DarkGreenBold,
              ),
            ],
          ),
          verticalSpacing(12),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              diagnosis.description,
              style: TextStyles.font14GrayRegular.copyWith(
                height: 1.6,
                color: ColorsManager.darkBlue,
              ),
            ),
          ),
          verticalSpacing(16),
          Divider(color: Colors.grey.shade200),
          verticalSpacing(12),
          _InfoRow(
            icon: Iconsax.calendar,
            label: 'Diagnosis Date',
            value: DateFormat(
              'MMMM dd, yyyy • hh:mm a',
            ).format(diagnosis.createdAt),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
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
