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
    required this.paymentMethod,
  });
  final int paymentType;
  final String appointmentPrice;
  final String paymentMethod;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CustomIconContainer(
              backgroundColor: ColorsManager.lighterGray,
              icon: Icons.payment,
              colorIcon: ColorsManager.primaryColor,
            ),
            horizantialSpacing(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Method",
                    style: TextStyles.font14GreenSemiBold.copyWith(
                      color: ColorsManager.darkBlue,
                    ),
                  ),
                  verticalSpacing(4),
                  Text(paymentMethod, style: TextStyles.font11GrayRegular),
                ],
              ),
            ),
          ],
        ),
        verticalSpacing(12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: ColorsManager.lighterMainBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Consultation Fee',
                style: TextStyles.font14GreenSemiBold.copyWith(
                  color: ColorsManager.darkBlue,
                ),
              ),
              Text(
                '$appointmentPrice EGP',
                style: TextStyles.font15DarkGreenMedium.copyWith(
                  color: ColorsManager.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
