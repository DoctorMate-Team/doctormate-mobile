import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppointmentEmptyState extends StatelessWidget {
  final String status;

  const AppointmentEmptyState({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: _getStatusColor(status).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getEmptyStateIcon(status),
                size: 80.sp,
                color: _getStatusColor(status),
              ),
            ),
            verticalSpacing(24),
            Text(
              _getEmptyStateTitle(status),
              style: TextStyles.font18DarkGreenBold,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(12),
            Text(
              _getEmptyStateMessage(status),
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'upcoming':
        return ColorsManager.primaryColor;
      case 'completed':
        return ColorsManager.green;
      case 'cancelled':
        return Colors.red;
      default:
        return ColorsManager.gray;
    }
  }

  IconData _getEmptyStateIcon(String status) {
    switch (status) {
      case 'upcoming':
        return Iconsax.calendar_add;
      case 'completed':
        return Iconsax.task_square;
      case 'cancelled':
        return Iconsax.close_square;
      default:
        return Iconsax.calendar;
    }
  }

  String _getEmptyStateTitle(String status) {
    switch (status) {
      case 'upcoming':
        return 'No Upcoming Appointments';
      case 'completed':
        return 'No Completed Appointments';
      case 'cancelled':
        return 'No Cancelled Appointments';
      default:
        return 'No Appointments';
    }
  }

  String _getEmptyStateMessage(String status) {
    switch (status) {
      case 'upcoming':
        return 'You don\'t have any upcoming appointments.\nBook one now to see it here.';
      case 'completed':
        return 'You haven\'t completed any appointments yet.\nYour appointment history will appear here.';
      case 'cancelled':
        return 'You haven\'t cancelled any appointments.\nCancelled appointments will appear here.';
      default:
        return 'No appointments found.';
    }
  }
}
