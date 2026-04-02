import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PrescriptionErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const PrescriptionErrorState({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.danger, size: 64.sp, color: Colors.red.withOpacity(0.5)),
          verticalSpacing(16),
          Text(
            'Failed to load prescription',
            style: TextStyles.font16DarkGreenBold,
          ),
          verticalSpacing(8),
          Text(error, style: TextStyles.font14GrayRegular),
          verticalSpacing(24),
          CustomMaterialButton(
            textButton: 'Retry',
            onPressed: onRetry,
            height: 48.h,
            minWidth: 150.w,
            raduisBorder: 12,
          ),
        ],
      ),
    );
  }
}
