import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/summary_booking/payment_type_summary.dart';
import 'package:flutter/material.dart';

class PaymentInformationSummary extends StatelessWidget {
  const PaymentInformationSummary({
    super.key,
    required this.appointmentPrice,
    this.paymentMethod = 'Not selected',
  });
  final String appointmentPrice;
  final String paymentMethod;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Information',
          style: TextStyles.font15DarkGreenMedium.copyWith(
            fontWeight: FontWeightHelper.semiBold,
          ),
        ),
        verticalSpacing(24),
        PaymentTypeSummary(
          paymentType: 0,
          appointmentPrice: appointmentPrice,
          paymentMethod: paymentMethod,
        ),
      ],
    );
  }
}
