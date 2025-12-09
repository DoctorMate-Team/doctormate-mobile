import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AppointmentInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20.sp, color: ColorsManager.primaryColor),
        verticalSpacing(4),
        Text(label, style: TextStyles.font11GrayRegular),
        verticalSpacing(2),
        Text(
          value,
          style: TextStyles.font12GrayRegular.copyWith(
            fontWeight: FontWeightHelper.semiBold,
            color: ColorsManager.darkBlue,
          ),
        ),
      ],
    );
  }
}
