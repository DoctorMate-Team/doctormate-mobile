import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/appointment_detail_row_widget.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/appointment_info_header_widget.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/doctor_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AppointmentInfoCard extends StatelessWidget {
  final PatientAppointmentModel appointment;

  const AppointmentInfoCard({super.key, required this.appointment});

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
          DoctorInfoWidget(doctor: appointment.doctor),
          Divider(height: 1, color: Colors.grey[200]),
          _buildAppointmentDetails(),
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
            value: DateFormat('EEEE, MMM dd, yyyy')
                .format(appointment.appointmentDate),
            iconColor: Colors.blue,
          ),
          verticalSpacing(12),
          AppointmentDetailRowWidget(
            icon: Iconsax.clock,
            label: 'Time',
            value: appointment.appointmentTime,
            iconColor: Colors.orange,
          ),
          verticalSpacing(12),
          AppointmentDetailRowWidget(
            icon: Iconsax.document_text,
            label: 'Reason',
            value: appointment.reason,
            iconColor: Colors.purple,
          ),
          verticalSpacing(12),
          AppointmentDetailRowWidget(
            icon: Iconsax.dollar_circle,
            label: 'Consultation Fee',
            value: '\$${appointment.doctor.consultationFee.toStringAsFixed(2)}',
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

