import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DiagnosisNoDataState extends StatelessWidget {
  const DiagnosisNoDataState({super.key});

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
                color: Colors.orange.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(Iconsax.health, size: 50.sp, color: Colors.orange),
            ),
            verticalSpacing(24),
            Text(
              'No Diagnosis Data',
              style: TextStyles.font18DarkGreenBold,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(12),
            Text(
              'Diagnosis information is not available for this record.',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(24),
            CustomMaterialButton(
              textButton: 'Go Back',
              onPressed: () => context.pop(),
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
