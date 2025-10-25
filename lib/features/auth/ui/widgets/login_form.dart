import 'package:doctor_mate/core/helper/app_regex.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    context.read<AuthCubit>().emailController.text = '';
    context.read<AuthCubit>().passwordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authCubit = context.read<AuthCubit>();
    return Form(
      key: authCubit.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: authCubit.emailController,
            hintText: "Email or Phone Number",
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPhoneNumberOrEmailValid("2$value")) {
                return "Please enter a valid email or phone number";
              }
            },
          ),
          verticalSpacing(24),
          CustomTextFormField(
            controller: authCubit.passwordController,
            hintText: "Password",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a password";
              }
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.pushNamed(Routes.forgetPassword);
              },
              child: Text(
                "Forgot Password?",
                style: TextStyles.font14GreenSemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
