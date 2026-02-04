import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/symptom_check_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DiagnosisResultCard extends StatelessWidget {
  final DiagnosisResultModel diagnosis;
  final String checkType;

  const DiagnosisResultCard({
    super.key,
    required this.diagnosis,
    required this.checkType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Initial Diagnosis', Iconsax.health, Colors.blue),
          _buildDivider(),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSeverityBadge(),
                if (diagnosis.description != null) ...[
                  verticalSpacing(16),
                  _buildDescription(),
                ],
                if (diagnosis.possibleCauses != null &&
                    diagnosis.possibleCauses!.isNotEmpty) ...[
                  verticalSpacing(20),
                  _buildPossibleCauses(),
                ],
                if (diagnosis.recommendations != null &&
                    diagnosis.recommendations!.isNotEmpty) ...[
                  verticalSpacing(20),
                  _buildRecommendations(),
                ],
                if (diagnosis.warningSymptoms != null &&
                    diagnosis.warningSymptoms!.isNotEmpty) ...[
                  verticalSpacing(20),
                  _buildWarningSymptoms(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              color is MaterialColor
                  ? [color.shade50, color.shade100]
                  : [color.withOpacity(0.1), color.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          horizantialSpacing(12),
          Text(
            title,
            style: TextStyles.font18DarkGreenBold.copyWith(
              color: color is MaterialColor ? color.shade800 : color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: Colors.grey.shade200);
  }

  Widget _buildSeverityBadge() {
    Color badgeColor;
    IconData badgeIcon;
    String severityText = diagnosis.severity?.toUpperCase() ?? 'UNKNOWN';

    switch (diagnosis.severity?.toLowerCase()) {
      case 'mild':
        badgeColor = Colors.green;
        badgeIcon = Iconsax.tick_circle;
        break;
      case 'moderate':
        badgeColor = Colors.orange;
        badgeIcon = Iconsax.info_circle;
        break;
      case 'severe':
        badgeColor = Colors.red;
        badgeIcon = Iconsax.danger;
        break;
      default:
        badgeColor = Colors.grey;
        badgeIcon = Iconsax.info_circle;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color:
            badgeColor is MaterialColor
                ? badgeColor.shade50
                : badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color:
              badgeColor is MaterialColor
                  ? badgeColor.shade200
                  : badgeColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            badgeIcon,
            color:
                badgeColor is MaterialColor ? badgeColor.shade700 : badgeColor,
            size: 18.sp,
          ),
          horizantialSpacing(6),
          Text(
            'Severity: $severityText',
            style: TextStyles.font14GreenSemiBold.copyWith(
              color:
                  badgeColor is MaterialColor
                      ? badgeColor.shade800
                      : badgeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Iconsax.document_text,
              color: ColorsManager.primaryColor,
              size: 18.sp,
            ),
            horizantialSpacing(6),
            Text('Description', style: TextStyles.font16DarkGreenBold),
          ],
        ),
        verticalSpacing(8),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Text(
            diagnosis.description!,
            style: TextStyles.font14DarkGreenMedium.copyWith(
              height: 1.6,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPossibleCauses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Iconsax.search_status, color: Colors.purple, size: 18.sp),
            horizantialSpacing(6),
            Text('Possible Causes', style: TextStyles.font16DarkGreenBold),
          ],
        ),
        verticalSpacing(12),
        ...diagnosis.possibleCauses!.asMap().entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  width: 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade400,
                    shape: BoxShape.circle,
                  ),
                ),
                horizantialSpacing(10),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyles.font14DarkGreenMedium.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Iconsax.heart_tick, color: Colors.green, size: 18.sp),
            horizantialSpacing(6),
            Text('Recommendations', style: TextStyles.font16DarkGreenBold),
          ],
        ),
        verticalSpacing(12),
        ...diagnosis.recommendations!.asMap().entries.map((entry) {
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.green.shade200, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: TextStyles.font12DarkGreenSemiBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                horizantialSpacing(10),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyles.font14DarkGreenMedium.copyWith(
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildWarningSymptoms() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.danger, color: Colors.red.shade700, size: 20.sp),
              horizantialSpacing(8),
              Text(
                'Seek Immediate Care If:',
                style: TextStyles.font16DarkGreenBold.copyWith(
                  color: Colors.red.shade900,
                ),
              ),
            ],
          ),
          verticalSpacing(12),
          ...diagnosis.warningSymptoms!.map((symptom) {
            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Iconsax.warning_2,
                    color: Colors.red.shade600,
                    size: 16.sp,
                  ),
                  horizantialSpacing(8),
                  Expanded(
                    child: Text(
                      symptom,
                      style: TextStyles.font14DarkGreenMedium.copyWith(
                        color: Colors.red.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
