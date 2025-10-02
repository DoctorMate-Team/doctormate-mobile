import 'package:doctor_mate/core/functions/custom_show_dialog.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/material.dart';

Future<dynamic> customLoadingDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
}) {
  return showCustomDialog(
    context,
    title: title,
    subtitle: subtitle,
    actions: [
      const Center(
        child: CircularProgressIndicator(color: ColorsManager.primaryColor),
      ),
    ],
  );
}
