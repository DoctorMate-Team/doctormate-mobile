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
      case 'lab results':
        return Colors.blue;
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
        return Iconsax.document_text;
    }
  }

  Color _getStatusColor() {
    switch (record.status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'reviewed':
        return Colors.blue;
      case 'archived':
        return Colors.grey;
      default:
        return ColorsManager.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    final recordColor = _getRecordTypeColor();
    final formattedDate = DateFormat(
      'MMM dd, yyyy • hh:mm a',
    ).format(DateTime.parse(record.recordedAt));

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
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
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            record.recordType,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'ID: ${record.id.substring(0, 8).toUpperCase()}',
                            style: TextStyles.font12GrayRegular.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: _getStatusColor().withOpacity(0.5),
                        ),
                      ),
                      child: Text(
                        record.status,
                        style: TextStyles.font12GrayRegular.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
                    // Title
                    Text(
                      record.title,
                      style: TextStyles.font16DarkGreenBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),

                    // Description
                    Text(
                      record.description,
                      style: TextStyles.font14GrayRegular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12.h),

                    // Doctor Info
                    if (record.doctorName != null)
                      Row(
                        children: [
                          Icon(
                            Iconsax.user_octagon,
                            size: 16.sp,
                            color: ColorsManager.darkBlue,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              'Dr. ${record.doctorName}',
                              style: TextStyles.font14DarkGreenMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    if (record.doctorName != null) SizedBox(height: 8.h),

                    // Date
                    Row(
                      children: [
                        Icon(
                          Iconsax.calendar,
                          size: 16.sp,
                          color: ColorsManager.gray,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          formattedDate,
                          style: TextStyles.font12GrayRegular,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // Recorded By
                    Row(
                      children: [
                        Icon(
                          Iconsax.user_tag,
                          size: 16.sp,
                          color: ColorsManager.gray,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Recorded by: ${record.recordedBy}',
                          style: TextStyles.font12GrayRegular,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions
              Divider(height: 1, color: Colors.grey.shade200),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onDownload != null)
                      TextButton.icon(
                        onPressed: onDownload,
                        icon: Icon(
                          Iconsax.document_download,
                          size: 18.sp,
                          color: ColorsManager.primaryColor,
                        ),
                        label: Text(
                          'Download',
                          style: TextStyles.font14GreenSemiBold,
                        ),
                      ),
                    if (onDownload != null) SizedBox(width: 8.w),
                    if (onShare != null)
                      TextButton.icon(
                        onPressed: onShare,
                        icon: Icon(
                          Iconsax.share,
                          size: 18.sp,
                          color: ColorsManager.darkBlue,
                        ),
                        label: Text(
                          'Share',
                          style: TextStyles.font14DarkGreenMedium,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
