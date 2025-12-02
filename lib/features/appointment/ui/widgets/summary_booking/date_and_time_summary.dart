import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_icon_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DateAndTimeSummary extends StatelessWidget {
  const DateAndTimeSummary({
    super.key,
  });

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
                Text('Date&Time',
                    style: TextStyles.font14GreenSemiBold
                        .copyWith(color: ColorsManager.darkBlue)),
                verticalSpacing(4),
                Text(
                    'No date selected',
                    style: TextStyles.font11GrayRegular),
                verticalSpacing(4),
                Text(
                    'No time selected',
                    style: TextStyles.font11GrayRegular),
              ],
            ),
          ],
        );
  }
}
