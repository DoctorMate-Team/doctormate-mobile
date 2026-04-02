import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppointmentErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const AppointmentErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.danger, size: 64.sp, color: Colors.red),
            SizedBox(height: 16.h),
            Text(
              'Error Loading Appointments',
              style: TextStyles.font18DarkGreenBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            CustomMaterialButton(
              textButton: 'Retry',
              onPressed: onRetry,
              backgroundColor: ColorsManager.primaryColor,
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
