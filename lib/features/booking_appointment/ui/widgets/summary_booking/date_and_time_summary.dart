import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_icon_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DateAndTimeSummary extends StatelessWidget {
  final String? selectedDate;
  final String? selectedTime;

  const DateAndTimeSummary({super.key, this.selectedDate, this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomIconContainer(
          backgroundColor: ColorsManager.lighterMainBlue,
          icon: Iconsax.calendar,
          colorIcon: ColorsManager.primaryColor,
        ),
        horizantialSpacing(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date & Time',
              style: TextStyles.font14GreenSemiBold.copyWith(
                color: ColorsManager.darkBlue,
              ),
            ),
            verticalSpacing(4),
            Text(
              selectedDate ?? 'No date selected',
              style: TextStyles.font11GrayRegular,
            ),
            verticalSpacing(4),
            Text(
              selectedTime != null
                  ? selectedTime!.substring(0, 5)
                  : 'No time selected',
              style: TextStyles.font11GrayRegular,
            ),
          ],
        ),
      ],
    );
  }
}
