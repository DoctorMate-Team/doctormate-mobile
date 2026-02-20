import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagnosisItemWidget extends StatelessWidget {
  final String icdCode;
  final String description;
  final String severity;

  const DiagnosisItemWidget({
    super.key,
    required this.icdCode,
    required this.description,
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  icdCode,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeightHelper.bold,
                  ),
                ),
              ),
              horizantialSpacing(8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getSeverityColor(severity).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: _getSeverityColor(severity).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  severity,
                  style: TextStyle(
                    color: _getSeverityColor(severity),
                    fontSize: 11.sp,
                    fontWeight: FontWeightHelper.medium,
                  ),
                ),
              ),
            ],
          ),
          verticalSpacing(8),
          Text(
            description,
            style: TextStyles.font14GrayRegular.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'severe':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
