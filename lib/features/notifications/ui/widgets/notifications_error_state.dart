import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const NotificationsErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.r, color: Colors.red.shade400),
          verticalSpacing(16),
          Text(
            'Error loading notifications',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          verticalSpacing(8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              message,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpacing(24),
          CustomMaterialButton(
            textButton: 'Retry',
            onPressed: onRetry,
            backgroundColor: ColorsManager.primaryColor,
            textColor: Colors.white,
            minWidth: 120.w,
            height: 45.h,
          ),
        ],
      ),
    );
  }
}
