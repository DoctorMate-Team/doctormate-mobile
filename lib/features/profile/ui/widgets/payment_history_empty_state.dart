import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PaymentHistoryEmptyState extends StatelessWidget {
  final bool isSearching;

  const PaymentHistoryEmptyState({super.key, required this.isSearching});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.wallet, size: 64.sp, color: Colors.grey.shade400),
          verticalSpacing(16),
          Text(
            isSearching ? 'No payments found' : 'No payment history yet',
            style: TextStyles.font16DarkGreenBold,
          ),
          verticalSpacing(8),
          Text(
            isSearching
                ? 'Try adjusting your search'
                : 'Your payment transactions will appear here',
            style: TextStyles.font14GrayRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
