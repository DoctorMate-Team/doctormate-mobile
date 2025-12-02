import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_icon_container.dart';
import 'package:flutter/material.dart';

class PaymentTypeSummary extends StatelessWidget {
  const PaymentTypeSummary({
    super.key,
    required this.paymentType,
    required this.appointmentPrice,
  });
  final int paymentType;
  final String appointmentPrice;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconContainer(
            backgroundColor: ColorsManager.lighterGray,
            icon: Icons.payment,
            colorIcon: ColorsManager.primaryColor),
        horizantialSpacing(12),
        Text(
            "Payment Method - ${appointmentPrice}EGP",
            style: TextStyles.font14GreenSemiBold
                .copyWith(color: ColorsManager.darkBlue)),
      ],
    );
  }
}
