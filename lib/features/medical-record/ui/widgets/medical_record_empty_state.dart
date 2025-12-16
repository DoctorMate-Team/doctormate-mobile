import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MedicalRecordEmptyState extends StatelessWidget {
  final String recordType;
  final VoidCallback? onAddPressed;

  const MedicalRecordEmptyState({
    super.key,
    required this.recordType,
    this.onAddPressed,
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
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.document_text,
                size: 60.sp,
                color: ColorsManager.primaryColor.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              recordType == 'All'
                  ? 'No Medical Records'
                  : 'No $recordType Records',
              style: TextStyles.font18DarkGreenBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              recordType == 'All'
                  ? 'Your medical records will appear here once they are added.'
                  : 'No $recordType records found. Try adjusting your filters.',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
            if (recordType == 'All' && onAddPressed != null) ...[
              SizedBox(height: 32.h),
              CustomMaterialButton(
                textButton: 'Add New Record',
                onPressed: onAddPressed!,
                height: 48.h,
                minWidth: 200.w,
                raduisBorder: 12,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
