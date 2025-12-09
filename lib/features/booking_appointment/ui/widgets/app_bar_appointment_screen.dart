import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppBarAppointmentScreen extends StatelessWidget {
  const AppBarAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.moreLighterGray,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Iconsax.arrow_left_2,
              color: ColorsManager.darkBlue,
              size: 20.sp,
            ),
            padding: EdgeInsets.all(8.r),
            constraints: const BoxConstraints(),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Book Appointment',
              style: TextStyles.font18DarkGreenBold.copyWith(
                color: ColorsManager.darkBlue,
                fontWeight: FontWeightHelper.semiBold,
              ),
            ),
          ),
        ),
        horizantialSpacing(40) // Balance for centered title
      ],
    );
  }
}
