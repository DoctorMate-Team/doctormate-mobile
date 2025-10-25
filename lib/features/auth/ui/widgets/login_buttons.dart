import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var authCubit = context.read<AuthCubit>();
    return Column(
      children: [
        CustomMaterialButton(
          textButton: "Login",
          onPressed: () {
            validateLogin(authCubit);
          },
        ),
        verticalSpacing(16),
        //Or
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text("Or", style: TextStyles.font18BlackBold),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        //Social Login
        verticalSpacing(16),
        CustomMaterialButton(
          textButton: "Facebook",
          backgroundColor: Colors.white,
          textColor: ColorsManager.primaryColor,
          onPressed: () {},
        ),
        verticalSpacing(16),
        CustomMaterialButton(
          textButton: "Google",
          backgroundColor: Colors.white,
          textColor: ColorsManager.primaryColor,
          onPressed: () {},
        ),
      ],
    );
  }

  void validateLogin(AuthCubit authCubit) {
    if (authCubit.formKey.currentState!.validate()) {
      authCubit.login();
    }
  }
}
