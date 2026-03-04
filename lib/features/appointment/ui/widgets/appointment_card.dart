import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'appointment_action_buttons.dart';
import 'appointment_info_item.dart';

class AppointmentCard extends StatelessWidget {
  final PatientAppointmentModel appointment;
  final String status;
  final VoidCallback onCancel;
  final VoidCallback onRefresh;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.status,
    required this.onCancel,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: _getStatusColor(status).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [_buildStatusHeader(), _buildAppointmentDetails(context)],
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getStatusIcon(status),
            size: 18.sp,
            color: _getStatusColor(status),
          ),
          horizantialSpacing(8),
          Text(
            _getStatusText(status),
            style: TextStyles.font12GrayRegular.copyWith(
              color: _getStatusColor(status),
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
          const Spacer(),
          Text(
            'ID: ${appointment.id.substring(0, 8).toUpperCase()}',
            style: TextStyles.font11GrayRegular.copyWith(
              color: ColorsManager.gray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildDoctorInfo(),
          verticalSpacing(16),
          _buildDateTimeReasonInfo(),
          verticalSpacing(16),
          AppointmentActionButtons(
            appointment: appointment,
            status: status,
            onCancel: onCancel,
            onRefresh: onRefresh,
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: CachedNetworkImage(
            imageUrl: appointment.doctor.image,
            width: 60.w,
            height: 60.h,
            fit: BoxFit.cover,
            placeholder:
                (context, url) => Container(
                  color: ColorsManager.moreLighterGray,
                  child: Icon(
                    Icons.person,
                    size: 30.sp,
                    color: ColorsManager.lightGray,
                  ),
                ),
            errorWidget:
                (context, url, error) => Container(
                  color: ColorsManager.moreLighterGray,
                  child: Icon(
                    Icons.person,
                    size: 30.sp,
                    color: ColorsManager.lightGray,
                  ),
                ),
          ),
        ),
        horizantialSpacing(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.doctor.doctorName,
                style: TextStyles.font15DarkGreenMedium.copyWith(
                  fontWeight: FontWeightHelper.semiBold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpacing(4),
              Row(
                children: [
                  Icon(
                    Iconsax.hospital,
                    size: 14.sp,
                    color: ColorsManager.gray,
                  ),
                  horizantialSpacing(4),
                  Expanded(
                    child: Text(
                      appointment.doctor.specialtyName,
                      style: TextStyles.font12GrayRegular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              verticalSpacing(4),
              Row(
                children: [
                  Icon(
                    Iconsax.location,
                    size: 14.sp,
                    color: ColorsManager.gray,
                  ),
                  horizantialSpacing(4),
                  Expanded(
                    child: Text(
                      appointment.doctor.address,
                      style: TextStyles.font11GrayRegular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeReasonInfo() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppointmentInfoItem(
                  icon: Iconsax.calendar_1,
                  label: 'Date',
                  value: DateFormat(
                    'MMM dd, yyyy',
                  ).format(appointment.appointmentDate),
                ),
              ),
              Container(width: 1, height: 40.h, color: Colors.grey.shade300),
              Expanded(
                child: AppointmentInfoItem(
                  icon: Iconsax.clock,
                  label: 'Time',
                  value: appointment.appointmentTime.substring(0, 5),
                ),
              ),
            ],
          ),
          if (appointment.reason.isNotEmpty) ...[
            verticalSpacing(12),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Iconsax.document_text,
                        size: 14.sp,
                        color: ColorsManager.primaryColor,
                      ),
                      horizantialSpacing(6),
                      Text(
                        'Reason',
                        style: TextStyles.font12GrayRegular.copyWith(
                          color: ColorsManager.darkBlue,
                          fontWeight: FontWeightHelper.medium,
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(6),
                  Text(
                    appointment.reason,
                    style: TextStyles.font12GrayRegular,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return ColorsManager.primaryColor;
      case 'completed':
        return ColorsManager.green;
      case 'cancelled':
        return Colors.red;
      case 'inprogress':
        return Colors.orange;
      default:
        return ColorsManager.gray;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'scheduled':
        return Iconsax.clock;
      case 'completed':
        return Iconsax.tick_circle;
      case 'cancelled':
        return Iconsax.close_circle;
      case 'inprogress':
        return Iconsax.play_circle;
      default:
        return Iconsax.info_circle;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'scheduled':
        return 'Scheduled';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'inprogress':
        return 'In Progress';
      default:
        return 'Unknown';
    }
  }
}
