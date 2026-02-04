import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecordModel record;
  final VoidCallback onTap;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;

  const MedicalRecordCard({
    super.key,
    required this.record,
    required this.onTap,
    this.onDownload,
    this.onShare,
  });

  Color _getRecordTypeColor() {
    switch (record.recordType.toLowerCase()) {
      case 'lab':
      case 'lab results':
        return Colors.blue;
      case 'prescription':
      case 'prescriptions':
        return Colors.green;
      case 'imaging':
        return Colors.purple;
      case 'diagnosis':
        return Colors.orange;
      case 'vaccination':
        return Colors.teal;
      case 'surgery':
        return Colors.red;
      default:
        return ColorsManager.primaryColor;
    }
  }

  IconData _getRecordTypeIcon() {
    switch (record.recordType.toLowerCase()) {
      case 'lab':
      case 'lab results':
        return Iconsax.microscope;
      case 'prescription':
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
        return Iconsax.document_text;
    }
  }

  String _getRecordTypeDisplayName(String recordType) {
    switch (recordType.toLowerCase()) {
      case 'lab':
        return 'LAB RESULTS';
      case 'prescription':
        return 'PRESCRIPTION';
      case 'imaging':
        return 'IMAGING';
      case 'diagnosis':
        return 'DIAGNOSIS';
      case 'vaccination':
        return 'VACCINATION';
      case 'surgery':
        return 'SURGERY';
      default:
        return recordType.toUpperCase();
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
      case 'severe':
        return Colors.red;
      case 'moderate':
        return Colors.orange;
      case 'mild':
      case 'low':
        return Colors.yellow.shade700;
      default:
        return Colors.blue;
    }
  }

  List<Widget> _buildDiagnosisInfo(DiagnosisModel diagnosis) {
    return [
      // Description
      Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              diagnosis.description,
              style: TextStyles.font14GrayRegular,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpacing(8),
            Row(
              children: [
                // Severity badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getSeverityColor(diagnosis.severity),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    diagnosis.severity.toUpperCase(),
                    style: TextStyles.font12GrayRegular.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                horizantialSpacing(8),
                // ICD Code
                Text(
                  'ICD: ${diagnosis.icdCode}',
                  style: TextStyles.font12GrayRegular.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      verticalSpacing(8),
      // Doctor Info
      Row(
        children: [
          Icon(
            Iconsax.user_octagon,
            size: 16.sp,
            color: ColorsManager.darkBlue,
          ),
          horizantialSpacing(6),
          Expanded(
            child: Text(
              'Dr. ${diagnosis.doctorName}',
              style: TextStyles.font14DarkGreenMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      verticalSpacing(8),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final recordColor = _getRecordTypeColor();
    final formattedDate = DateFormat(
      'MMM dd, yyyy • hh:mm a',
    ).format(record.recordedAt);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: recordColor.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          splashColor: recordColor.withOpacity(0.1),
          highlightColor: recordColor.withOpacity(0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with gradient
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      recordColor.withOpacity(0.8),
                      recordColor.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        _getRecordTypeIcon(),
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    horizantialSpacing(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getRecordTypeDisplayName(record.recordType),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          verticalSpacing(2),
                          Text(
                            'ID: ${record.id.length > 8 ? record.id.substring(0, 8).toUpperCase() : record.id.toUpperCase()}',
                            style: TextStyles.font12GrayRegular.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with icon
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: recordColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Iconsax.document_text,
                            size: 16.sp,
                            color: recordColor,
                          ),
                        ),
                        horizantialSpacing(10),
                        Expanded(
                          child: Text(
                            record.title,
                            style: TextStyles.font16DarkGreenBold.copyWith(
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    verticalSpacing(14),

                    // Show diagnosis details if available
                    if (record.diagnoses != null &&
                        record.diagnoses!.isNotEmpty)
                      ..._buildDiagnosisInfo(record.diagnoses!.first),

                    // Date with enhanced styling
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.calendar,
                            size: 16.sp,
                            color: ColorsManager.primaryColor,
                          ),
                          horizantialSpacing(8),
                          Text(
                            formattedDate,
                            style: TextStyles.font12GrayRegular.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Actions with enhanced styling
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // View Details button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onTap,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: recordColor,
                            side: BorderSide(color: recordColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 10.h,
                            ),
                          ),
                          icon: Icon(Iconsax.eye, size: 16.sp),
                          label: Text(
                            'View Details',
                            style: TextStyles.font14GreenSemiBold.copyWith(
                              color: recordColor,
                            ),
                          ),
                        ),
                      ),
                      if (onDownload != null || onShare != null)
                        horizantialSpacing(8),
                      // Action buttons
                      if (onDownload != null)
                        IconButton(
                          onPressed: onDownload,
                          icon: Icon(
                            Iconsax.document_download,
                            size: 20.sp,
                            color: ColorsManager.primaryColor,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: ColorsManager.primaryColor
                                .withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      if (onShare != null) horizantialSpacing(4),
                      if (onShare != null)
                        IconButton(
                          onPressed: onShare,
                          icon: Icon(
                            Iconsax.share,
                            size: 20.sp,
                            color: ColorsManager.darkBlue,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: ColorsManager.darkBlue.withOpacity(
                              0.1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
