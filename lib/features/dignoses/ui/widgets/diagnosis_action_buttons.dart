import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DiagnosisActionButtons extends StatelessWidget {
  final DiagnosisModel diagnosis;

  const DiagnosisActionButtons({super.key, required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomMaterialButton(
                textButton: 'Download Report',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Download functionality coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
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
                textButton: 'View Prescription',
                onPressed: () {
                  context.push(
                    '${Routes.prescriptionsScreen}?diagnosisId=${diagnosis.id}&appointmentId=${diagnosis.appointmentId}',
                  );
                },
                backgroundColor: Colors.green,
                height: 48.h,
                raduisBorder: 12,
              ),
            ),
          ],
        ),
        verticalSpacing(12),
        CustomMaterialButton(
          textButton: 'Contact Doctor',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Contact Dr. ${diagnosis.doctorName}'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          height: 48.h,
          raduisBorder: 12,
        ),
      ],
    );
  }
}
