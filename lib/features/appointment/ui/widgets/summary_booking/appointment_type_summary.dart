import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_icon_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppointmentTypeSummary extends StatelessWidget {
  const AppointmentTypeSummary({super.key, required this.appointmentType});
  final int appointmentType;
  @override
  Widget build(BuildContext context) {
    String typeText;
    switch (appointmentType) {
      case 0:
        typeText = 'Video Call';
        break;
      case 1:
        typeText = 'Voice Call';
        break;
      case 2:
        typeText = 'In-Person Visit';
        break;
      default:
        typeText = 'Not specified';
    }

    return Row(
      children: [
        const CustomIconContainer(
          backgroundColor: ColorsManager.lightGreen,
          icon: Iconsax.clipboard,
          colorIcon: ColorsManager.green,
        ),
        horizantialSpacing(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment Type',
              style: TextStyles.font14GreenSemiBold.copyWith(
                color: ColorsManager.darkBlue,
              ),
            ),
            verticalSpacing(4),
            Text(typeText, style: TextStyles.font11GrayRegular),
          ],
        ),
      ],
    );
  }
}
