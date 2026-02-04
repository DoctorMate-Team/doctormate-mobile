import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResultActionButtons extends StatelessWidget {
  const ResultActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomMaterialButton(
            textButton: 'New Checkup',
            onPressed: () {
              context.pop();
            },
            backgroundColor: Colors.white,
            borderColor: ColorsManager.primaryColor,
            textColor: ColorsManager.primaryColor,
            height: 50.h,
            raduisBorder: 12,
          ),
        ),
        horizantialSpacing(12),
        Expanded(
          child: CustomMaterialButton(
            textButton: 'Save Report',
            onPressed: () {
              // TODO: Save report
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Report saved successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            height: 50.h,
            raduisBorder: 12,
          ),
        ),
      ],
    );
  }
}
