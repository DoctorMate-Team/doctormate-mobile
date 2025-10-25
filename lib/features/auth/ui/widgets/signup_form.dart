import 'package:doctor_mate/core/helper/app_regex.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
            controller: authCubit.nameController,
            hintText: "Name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a name";
              }
            },
          ),
          verticalSpacing(24),
          CustomTextFormField(
            controller: authCubit.emailController,
            hintText: "Email",
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return "Please enter a valid email or phone number";
              }
            },
          ),
          verticalSpacing(24),
          CustomTextFormField(
            controller: authCubit.phoneNumberController,
            hintText: "Mobile Number",
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isPhoneNumberValid("2$value")) {
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
          verticalSpacing(24),
          CustomTextFormField(
            controller: authCubit.passwordConfirmationController,
            hintText: "Confirm Password",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a password";
              }
            },
          ),
        ],
      ),
    );
  }
}
