import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(hintText: "Name", validator: (value) {}),
        verticalSpacing(24),
        CustomTextFormField(hintText: "Email", validator: (value) {}),
        verticalSpacing(24),
        CustomTextFormField(hintText: "Mobile Number", validator: (value) {}),
        verticalSpacing(24),
        CustomTextFormField(hintText: "Password", validator: (value) {}),
        verticalSpacing(24),
        CustomTextFormField(
          hintText: "Confirm Password",
          validator: (value) {},
        ),
      ],
    );
  }
}