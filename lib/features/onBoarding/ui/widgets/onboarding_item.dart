import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/onBoarding/data/models/onBoarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingItem extends StatelessWidget {
  final OnboardingModel model;

  const OnBoardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Added SingleChildScrollView to prevent overflow
      child: Column(
        children: [
          Image.asset(
            model.image,
            width: 390.w,
            height: 464.h,
            fit: BoxFit.cover,
          ),
          verticalSpacing(21),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: TextStyles.font24GreenBold,
                ),
                verticalSpacing(24),
                SizedBox(
                  width: 320.w,
                  child: Text(
                    model.description,
                    style: TextStyles.font14GrayRegular,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
