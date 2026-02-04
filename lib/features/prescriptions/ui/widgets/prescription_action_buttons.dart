import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionActionButtons extends StatelessWidget {
  const PrescriptionActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomMaterialButton(
                textButton: 'Download',
                onPressed: () {
                  // TODO: Implement download
                },
                backgroundColor: Colors.white,
                textColor: ColorsManager.primaryColor,
                height: 48.h,
                raduisBorder: 12,
                borderColor: ColorsManager.primaryColor,
              ),
            ),
            horizantialSpacing(12),
            Expanded(
              child: CustomMaterialButton(
                textButton: 'Share',
                onPressed: () {
                  // TODO: Implement share
                },
                backgroundColor: Colors.white,
                textColor: ColorsManager.primaryColor,
                height: 48.h,
                raduisBorder: 12,
                borderColor: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
        verticalSpacing(12),
        CustomMaterialButton(
          textButton: 'Contact Doctor',
          onPressed: () {
            // TODO: Implement contact
          },
          height: 48.h,
          raduisBorder: 12,
        ),
      ],
    );
  }
}
