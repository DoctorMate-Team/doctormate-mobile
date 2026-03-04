import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/models/notification_type.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(timestamp),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Iconsax.trash, color: Colors.white, size: 24.sp),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color:
                isRead
                    ? Colors.white
                    : ColorsManager.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color:
                  isRead
                      ? Colors.grey.shade200
                      : ColorsManager.primaryColor.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: _getTypeColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  _getTypeIcon(),
                  color: _getTypeColor(),
                  size: 24.sp,
                ),
              ),
              horizantialSpacing(12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyles.font14GreenSemiBold.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: ColorsManager.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    verticalSpacing(4),
                    Text(
                      message,
                      style: TextStyles.font13LightGrayRegular.copyWith(
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpacing(8),
                    Row(
                      children: [
                        Icon(
                          Iconsax.clock,
                          size: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                        horizantialSpacing(4),
                        Text(
                          _formatTimestamp(),
                          style: TextStyles.font11GrayRegular.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        horizantialSpacing(8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            _getTypeText(),
                            style: TextStyles.font10DarkGreenRegular.copyWith(
                              color: _getTypeColor(),
                              fontSize: 9.sp,
                            ),
                          ),
                        ),
                      ],
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

  Color _getTypeColor() {
    switch (type) {
      case NotificationType.diagnosisAdded:
        return Colors.orange.shade600;
      case NotificationType.appointmentReminder:
        return Colors.blue.shade600;
      case NotificationType.appointmentConfirmed:
        return Colors.green.shade600;
      case NotificationType.appointmentCancelled:
        return Colors.red.shade600;
      case NotificationType.prescriptionCreated:
        return Colors.purple.shade600;
      case NotificationType.unknown:
        return Colors.grey.shade600;
    }
  }

  IconData _getTypeIcon() {
    switch (type) {
      case NotificationType.diagnosisAdded:
        return Iconsax.health;
      case NotificationType.appointmentReminder:
        return Iconsax.calendar;
      case NotificationType.appointmentConfirmed:
        return Iconsax.tick_circle;
      case NotificationType.appointmentCancelled:
        return Iconsax.close_circle;
      case NotificationType.prescriptionCreated:
        return Iconsax.note_21;
      case NotificationType.unknown:
        return Iconsax.info_circle;
    }
  }

  String _getTypeText() {
    switch (type) {
      case NotificationType.diagnosisAdded:
        return 'Diagnosis';
      case NotificationType.appointmentReminder:
        return 'Reminder';
      case NotificationType.appointmentConfirmed:
        return 'Confirmed';
      case NotificationType.appointmentCancelled:
        return 'Cancelled';
      case NotificationType.prescriptionCreated:
        return 'Prescription';
      case NotificationType.unknown:
        return 'Info';
    }
  }

  String _formatTimestamp() {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(timestamp);
    }
  }
}
