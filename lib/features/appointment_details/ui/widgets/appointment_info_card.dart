import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/appointment_detail_row_widget.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/appointment_info_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AppointmentInfoCard extends StatelessWidget {
  final AppointmentDetailsResponse appointmentDetails;

  const AppointmentInfoCard({super.key, required this.appointmentDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const AppointmentInfoHeaderWidget(),
          Divider(height: 1, color: Colors.grey[200]),
          _buildDoctorInfo(),
          Divider(height: 1, color: Colors.grey[200]),
          _buildAppointmentDetails(),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              appointmentDetails.doctorImage,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    width: 60.w,
                    height: 60.h,
                    color: Colors.grey[300],
                    child: const Icon(Icons.person),
                  ),
            ),
          ),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointmentDetails.doctorName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpacing(4),
                Text(
                  appointmentDetails.specialty,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          AppointmentDetailRowWidget(
            icon: Iconsax.calendar,
            label: 'Date',
            value: DateFormat(
              'EEEE, MMM dd, yyyy',
            ).format(appointmentDetails.scheduledStart),
            iconColor: Colors.blue,
          ),
          verticalSpacing(12),
          AppointmentDetailRowWidget(
            icon: Iconsax.clock,
            label: 'Time',
            value:
                '${DateFormat('hh:mm a').format(appointmentDetails.scheduledStart)} - ${DateFormat('hh:mm a').format(appointmentDetails.scheduledEnd)}',
            iconColor: Colors.orange,
          ),
          verticalSpacing(12),
          AppointmentDetailRowWidget(
            icon: Iconsax.document_text,
            label: 'Reason',
            value: appointmentDetails.reason,
            iconColor: Colors.purple,
          ),
          verticalSpacing(12),
          AppointmentDetailRowWidget(
            icon: Iconsax.dollar_circle,
            label: 'Consultation Fee',
            value: '\$${appointmentDetails.price.toStringAsFixed(2)}',
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
