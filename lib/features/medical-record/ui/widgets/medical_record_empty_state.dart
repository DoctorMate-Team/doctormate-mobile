import 'package:doctor_mate/core/helper/spacing.dart';
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
      child: SingleChildScrollView(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated icon container
            Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorsManager.primaryColor.withOpacity(0.1),
                    ColorsManager.primaryColor.withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primaryColor.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background decorative circles
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                        color: ColorsManager.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: ColorsManager.primaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Main icon
                  Icon(
                    _getIconForRecordType(),
                    size: 70.sp,
                    color: ColorsManager.primaryColor,
                  ),
                ],
              ),
            ),
            verticalSpacing(32),
            Text(
              recordType == 'All'
                  ? 'No Medical Records Yet'
                  : 'No ${_getDisplayName()} Records',
              style: TextStyles.font18DarkGreenBold.copyWith(fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                _getEmptyStateMessage(),
                style: TextStyles.font14GrayRegular.copyWith(height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            if (recordType == 'All' && onAddPressed != null) ...[
              verticalSpacing(40),
              CustomMaterialButton(
                textButton: 'Add New Record',
                onPressed: onAddPressed!,
                height: 50.h,
                minWidth: 220.w,
                raduisBorder: 12,
              ),
              verticalSpacing(12),
              Text(
                'Your health records in one place',
                style: TextStyles.font12GrayRegular.copyWith(
                  color: ColorsManager.gray.withOpacity(0.7),
                ),
              ),
            ],
            if (recordType != 'All') ...[
              verticalSpacing(32),
              OutlinedButton.icon(
                onPressed: () {
                  // Will be handled by parent to show all records
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorsManager.primaryColor,
                  side: BorderSide(color: ColorsManager.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                ),
                icon: Icon(Iconsax.filter_remove, size: 18.sp),
                label: Text(
                  'Clear Filters',
                  style: TextStyles.font14GreenSemiBold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getIconForRecordType() {
    switch (recordType.toLowerCase()) {
      case 'lab results':
        return Iconsax.microscope;
      case 'prescriptions':
        return Iconsax.note_21;
      case 'imaging':
        return Iconsax.scan;
      case 'diagnosis':
        return Iconsax.health;
      case 'vaccination':
        return Iconsax.shield_tick;
      case 'surgery':
        return Iconsax.hospital;
      default:
        return Iconsax.folder_open;
    }
  }

  String _getDisplayName() {
    switch (recordType.toLowerCase()) {
      case 'lab results':
        return 'Lab';
      case 'prescriptions':
        return 'Prescription';
      case 'imaging':
        return 'Imaging';
      case 'diagnosis':
        return 'Diagnosis';
      case 'vaccination':
        return 'Vaccination';
      case 'surgery':
        return 'Surgery';
      default:
        return recordType;
    }
  }

  String _getEmptyStateMessage() {
    if (recordType == 'All') {
      return 'Your medical records will appear here once they are added by your healthcare providers. This includes lab results, prescriptions, imaging reports, and more.';
    }
    return 'No ${_getDisplayName().toLowerCase()} records found. Try adjusting your filters or check back later for updates from your healthcare team.';
  }
}
