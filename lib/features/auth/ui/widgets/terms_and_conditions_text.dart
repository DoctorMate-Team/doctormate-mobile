import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By logging, you agree to our',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: ' Terms & Conditions',
            style: TextStyles.font13DarkGreenMedium,
          ),
          TextSpan(
            text: ' and',
            style: TextStyles.font13LightGrayRegular.copyWith(height: 1.5),
          ),
          TextSpan(
            text: ' Privacy Policy.',
            style: TextStyles.font13DarkGreenMedium,
          ),
        ],
      ),
    );
  }
}
