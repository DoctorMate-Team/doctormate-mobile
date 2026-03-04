import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppointmentActionButtons extends StatelessWidget {
  final PatientAppointmentModel appointment;
  final String status;
  final VoidCallback onCancel;
  final VoidCallback onRefresh;

  const AppointmentActionButtons({
    super.key,
    required this.appointment,
    required this.status,
    required this.onCancel,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (status == 'scheduled') {
      return Row(
        children: [
          Expanded(
            child: CustomMaterialButton(
              textButton: 'Cancel',
              icon: Iconsax.close_circle,
              onPressed: onCancel,
              backgroundColor: Colors.white,
              textColor: Colors.red,
              borderColor: Colors.red,
              height: 48.h,
              raduisBorder: 12,
            ),
          ),
          horizantialSpacing(12),
          Expanded(
            child: CustomMaterialButton(
              textButton: 'Reschedule',
              icon: Iconsax.calendar_edit,
              onPressed: () async {
                final result = await context.pushNamed(
                  Routes.rescheduleAppointment,
                  extra: appointment,
                );
                // If rescheduled successfully, trigger refresh
                if (result == true) {
                  onRefresh();
                }
              },
              backgroundColor: ColorsManager.primaryColor,
              height: 48.h,
              raduisBorder: 12,
            ),
          ),
        ],
      );
    } else if (status == 'completed' || status == 'inprogress') {
      return Row(
        children: [
          Expanded(
            child: CustomMaterialButton(
              textButton: 'View Details',
              icon: Iconsax.eye,
              onPressed: () {
                context.pushNamed(
                  Routes.appointmentDetails,
                  extra: appointment,
                );
              },
              backgroundColor: Colors.white,
              textColor: ColorsManager.primaryColor,
              borderColor: ColorsManager.primaryColor,
              height: 48.h,
              raduisBorder: 12,
            ),
          ),
          horizantialSpacing(12),
          Expanded(
            child: CustomMaterialButton(
              textButton: 'Book Again',
              icon: Iconsax.repeat,
              onPressed: () {
                context.pushNamed(
                  Routes.detailsScreen,
                  extra: appointment.doctor.id,
                );
              },
              backgroundColor: ColorsManager.primaryColor,
              height: 48.h,
              raduisBorder: 12,
            ),
          ),
        ],
      );
    } else {
      // cancelled
      return CustomMaterialButton(
        textButton: 'Book New Appointment',
        icon: Iconsax.calendar_add,
        onPressed: () {
          context.pushNamed(Routes.detailsScreen, extra: appointment.doctor.id);
        },
        backgroundColor: ColorsManager.primaryColor,
        height: 48.h,
        raduisBorder: 12,
      );
    }
  }
}
