import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/smart_check_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ResultHeaderCard extends StatelessWidget {
  final SmartCheckResponse checkupResult;

  const ResultHeaderCard({super.key, required this.checkupResult});

  @override
  Widget build(BuildContext context) {
    Color severityColor = Colors.green;
    IconData severityIcon = Iconsax.tick_circle;

    if (checkupResult.severity.toLowerCase() == 'moderate') {
      severityColor = Colors.orange;
      severityIcon = Iconsax.info_circle;
    } else if (checkupResult.severity.toLowerCase() == 'severe') {
      severityColor = Colors.red;
      severityIcon = Iconsax.danger;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              severityColor is MaterialColor
                  ? [severityColor.shade600, severityColor.shade400]
                  : [severityColor, severityColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: severityColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(severityIcon, color: Colors.white, size: 28.sp),
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analysis Complete',
                      style: TextStyles.font14DarkGreenMedium.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    verticalSpacing(4),
                    Text(
                      checkupResult.possibleDiagnosis,
                      style: TextStyles.font18DarkGreenBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Iconsax.chart, color: Colors.white, size: 16.sp),
                horizantialSpacing(6),
                Text(
                  'Confidence: ${checkupResult.confidence.toStringAsFixed(0)}%',
                  style: TextStyles.font12DarkGreenSemiBold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
