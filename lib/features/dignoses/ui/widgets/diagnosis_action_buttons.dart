import 'package:doctor_mate/core/functions/pdf_share_helper.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DiagnosisActionButtons extends StatelessWidget {
  final DiagnosisModel diagnosis;

  const DiagnosisActionButtons({super.key, required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Download Report Button
        CustomMaterialButton(
          textButton: 'Download Report',
          onPressed: () => PdfShareHelper.shareDiagnosisPdf(context, diagnosis),
          backgroundColor: Colors.white,
          textColor: ColorsManager.primaryColor,
          height: 50.h,
          raduisBorder: 12,
          borderColor: ColorsManager.primaryColor,
          icon: Iconsax.document_download,
        ),
        verticalSpacing(12),

        // Share Report Button
        CustomMaterialButton(
          textButton: 'Share Report',
          onPressed:
              () => PdfShareHelper.shareDiagnosisText(context, diagnosis),
          backgroundColor: ColorsManager.primaryColor,
          textColor: Colors.white,
          height: 50.h,
          raduisBorder: 12,
          icon: Iconsax.share,
        ),
        verticalSpacing(12),

        // View Prescription Button
        CustomMaterialButton(
          textButton: 'View Prescription',
          onPressed: () {
            context.push(
              '${Routes.prescriptionsScreen}?diagnosisId=${diagnosis.id}&appointmentId=${diagnosis.appointmentId}',
            );
          },
          backgroundColor: Colors.green,
          textColor: Colors.white,
          height: 50.h,
          raduisBorder: 12,
          icon: Iconsax.note_21,
        ),
        verticalSpacing(12),

        // Contact Doctor Button
        CustomMaterialButton(
          textButton: 'Contact Doctor',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Contact Dr. ${diagnosis.doctorName}'),
                duration: const Duration(seconds: 2),
                backgroundColor: ColorsManager.primaryColor,
              ),
            );
          },
          backgroundColor: Colors.white,
          textColor: ColorsManager.primaryColor,
          height: 50.h,
          raduisBorder: 12,
          borderColor: ColorsManager.primaryColor,
          icon: Iconsax.call,
        ),
      ],
    );
  }
}
