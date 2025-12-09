import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppointmentActionButtons extends StatelessWidget {
  final PatientAppointmentModel appointment;
  final String status;
  final VoidCallback onCancel;
  final VoidCallback onReschedule;

  const AppointmentActionButtons({
    super.key,
    required this.appointment,
    required this.status,
    required this.onCancel,
    required this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    if (status == 'upcoming') {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onCancel,
              icon: Icon(Iconsax.close_circle, size: 18.sp),
              label: const Text('Cancel'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          horizantialSpacing(12),
          Expanded(
            child: CustomMaterialButton(
              textButton: 'Reschedule',
              onPressed: onReschedule,
              backgroundColor: ColorsManager.primaryColor,
              height: 48.h,
              raduisBorder: 12,
            ),
          ),
        ],
      );
    } else if (status == 'completed') {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: View details
              },
              icon: Icon(Iconsax.eye, size: 18.sp),
              label: const Text('View Details'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorsManager.primaryColor,
                side: BorderSide(color: ColorsManager.primaryColor),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          horizantialSpacing(12),
          Expanded(
            child: CustomMaterialButton(
              textButton: 'Book Again',
              onPressed: () {
                // TODO: Book again with same doctor
              },
              backgroundColor: ColorsManager.green,
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
        onPressed: () {
          // TODO: Book again with same doctor
        },
        backgroundColor: ColorsManager.primaryColor,
        height: 48.h,
        raduisBorder: 12,
      );
    }
  }
}
