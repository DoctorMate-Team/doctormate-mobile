import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PaymentAppointmentContent extends StatefulWidget {
  const PaymentAppointmentContent({super.key});

  @override
  State<PaymentAppointmentContent> createState() =>
      _PaymentAppointmentContentState();
}

class _PaymentAppointmentContentState extends State<PaymentAppointmentContent> {
  int selectedPayment = 0;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'icon': Iconsax.wallet,
      'title': 'Cash Payment',
      'description': 'Pay at clinic',
      'color': ColorsManager.green,
      'bgColor': ColorsManager.lightGreen,
    },
    {
      'icon': Iconsax.card,
      'title': 'Credit Card',
      'description': 'Visa, Mastercard',
      'color': ColorsManager.primaryColor,
      'bgColor': ColorsManager.lighterMainBlue,
    },
    {
      'icon': Icons.account_balance_wallet_outlined,
      'title': 'Digital Wallet',
      'description': 'Vodafone Cash, etc',
      'color': ColorsManager.gold,
      'bgColor': const Color(0xFFFFF9E6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: TextStyles.font15DarkGreenMedium.copyWith(
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
          verticalSpacing(16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: paymentMethods.length,
            separatorBuilder: (context, index) => verticalSpacing(12),
            itemBuilder: (context, index) {
              final method = paymentMethods[index];
              final isSelected = selectedPayment == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPayment = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient:
                        isSelected
                            ? LinearGradient(
                              colors: [
                                method['bgColor'],
                                method['bgColor'].withOpacity(0.6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                            : null,
                    color: isSelected ? null : ColorsManager.moreLighterGray,
                    border: Border.all(
                      color: isSelected ? method['color'] : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: method['color'].withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                            : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : method['bgColor'],
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow:
                              isSelected
                                  ? [
                                    BoxShadow(
                                      color: method['color'].withOpacity(0.15),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                  : null,
                        ),
                        child: Icon(
                          method['icon'],
                          color: method['color'],
                          size: 28.sp,
                        ),
                      ),
                      horizantialSpacing(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['title'],
                              style: TextStyles.font15DarkGreenMedium.copyWith(
                                color: ColorsManager.darkBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            verticalSpacing(4),
                            Text(
                              method['description'],
                              style: TextStyles.font12GrayRegular,
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 24.r,
                        height: 24.r,
                        decoration: BoxDecoration(
                          color:
                              isSelected ? method['color'] : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected
                                    ? method['color']
                                    : ColorsManager.lightGray,
                            width: 2,
                          ),
                        ),
                        child:
                            isSelected
                                ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14.sp,
                                )
                                : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
