import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DiagnosisHeaderCard extends StatelessWidget {
  final DiagnosisModel diagnosis;
  final Color severityColor;

  const DiagnosisHeaderCard({
    super.key,
    required this.diagnosis,
    required this.severityColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primaryColor,
            ColorsManager.primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.health, color: Colors.white, size: 28.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnosis Report',
                      style: TextStyles.font14WhiteRegular.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'ID: ${diagnosis.id.length > 12 ? diagnosis.id.substring(0, 12).toUpperCase() : diagnosis.id.toUpperCase()}',
                      style: TextStyles.font12GrayRegular.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: severityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.danger, color: Colors.white, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      diagnosis.severity.toUpperCase(),
                      style: TextStyles.font12GrayRegular.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Medical Diagnosis',
            style: TextStyles.font18DarkGreenBold.copyWith(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Iconsax.code_circle, color: Colors.white, size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                'ICD-10: ${diagnosis.icdCode}',
                style: TextStyles.font14GrayRegular.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
