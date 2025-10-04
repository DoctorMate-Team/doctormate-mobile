import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(hintText: "Email", validator: (value) {}),
        verticalSpacing(24),
        CustomTextFormField(hintText: "Password", validator: (value) {}),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //CheckBox Remember Me
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  activeColor: ColorsManager.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  side: BorderSide(color: ColorsManager.primaryColor),
                  checkColor: Colors.white,
                  focusColor: ColorsManager.primaryColor,
                  hoverColor: ColorsManager.primaryColor,
                ),
                Text("Remember Me", style: TextStyles.font14GrayRegular),
              ],
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(Routes.forgetPassword);
              },
              child: Text(
                "Forgot Password?",
                style: TextStyles.font14GreenSemiBold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
