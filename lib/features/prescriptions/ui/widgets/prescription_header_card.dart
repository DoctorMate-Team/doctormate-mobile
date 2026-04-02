import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class PrescriptionHeaderCard extends StatelessWidget {
  final PrescriptionDetailsResponse prescription;
  final Color statusColor;

  const PrescriptionHeaderCard({
    super.key,
    required this.prescription,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade600, Colors.green.shade400],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.note_21, color: Colors.white, size: 28.sp),
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medical Prescription',
                      style: TextStyles.font14WhiteRegular.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpacing(4),
                    Text(
                      'Rx: ${prescription.id.substring(0, 12).toUpperCase()}',
                      style: TextStyles.font12GrayRegular.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      prescription.appointment?.status.toLowerCase() == 'active'
                          ? Iconsax.tick_circle
                          : Iconsax.info_circle,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                    horizantialSpacing(4),
                    Text(
                      prescription.appointment?.status ?? 'Unknown',
                      style: TextStyles.font12GrayRegular.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          Row(
            children: [
              Icon(Iconsax.calendar, color: Colors.white, size: 16.sp),
              horizantialSpacing(6),
              Text(
                'Prescribed: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(prescription.appointment?.scheduledStart ?? DateTime.now().toIso8601String()))}',
                style: TextStyles.font14GrayRegular.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
