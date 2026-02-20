import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const SearchErrorState({
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
          Icon(Iconsax.danger, size: 50.sp, color: Colors.red.shade400),
          verticalSpacing(16),
          Text('Error loading doctors', style: TextStyles.font18DarkGreenBold),
          verticalSpacing(8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              error,
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpacing(16),
          CustomMaterialButton(
            textButton: 'Retry',
            onPressed: onRetry,
            minWidth: 120.w,
          ),
        ],
      ),
    );
  }
}
