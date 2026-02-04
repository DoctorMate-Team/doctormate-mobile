import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalRecordErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const MedicalRecordErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 50.sp,
                color: Colors.red.shade400,
              ),
            ),
            verticalSpacing(24),
            Text(
              'Unable to Load Records',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(12),
            Text(
              message,
              style: TextStyle(fontSize: 14.sp, color: ColorsManager.gray),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(24),
            CustomMaterialButton(
              textButton: 'Try Again',
              onPressed: onRetry,
              height: 48.h,
              minWidth: 150.w,
              raduisBorder: 12,
            ),
          ],
        ),
      ),
    );
  }
}
