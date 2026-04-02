import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationsEmptyState extends StatelessWidget {
  final String? filterType;
  final VoidCallback? onRefresh;

  const NotificationsEmptyState({super.key, this.filterType, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.notification,
                size: 80.sp,
                color: ColorsManager.primaryColor.withOpacity(0.5),
              ),
            ),
            verticalSpacing(24),

            // Title
            Text(
              _getTitle(),
              style: TextStyles.font18DarkGreenBold,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(8),

            // Description
            Text(
              _getDescription(),
              style: TextStyles.font14LightGrayRegular,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(32),

            // Refresh Button (if provided)
            if (onRefresh != null)
              CustomMaterialButton(
                textButton: 'Refresh',
                onPressed: onRefresh!,
                backgroundColor: ColorsManager.primaryColor,
                textColor: Colors.white,
                height: 44.h,
                minWidth: 120.w,
                raduisBorder: 8,
                icon: Iconsax.refresh,
              ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    if (filterType != null && filterType != 'All') {
      return 'No $filterType Notifications';
    }
    return 'No Notifications Yet';
  }

  String _getDescription() {
    if (filterType != null && filterType != 'All') {
      return 'You don\'t have any $filterType notifications at the moment.';
    }
    return 'When you receive notifications about appointments,\ndiagnoses, or prescriptions, they\'ll appear here.';
  }
}
