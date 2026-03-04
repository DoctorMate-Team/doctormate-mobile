import 'package:doctor_mate/core/functions/pdf_share_helper.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PrescriptionActionButtons extends StatelessWidget {
  final PrescriptionDetailsResponse prescription;

  const PrescriptionActionButtons({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Download Prescription Button
        CustomMaterialButton(
          textButton: 'Download Prescription',
          onPressed:
              () => PdfShareHelper.sharePrescriptionPdf(context, prescription),
          backgroundColor: Colors.white,
          textColor: ColorsManager.primaryColor,
          height: 50.h,
          raduisBorder: 12,
          borderColor: ColorsManager.primaryColor,
          icon: Iconsax.document_download,
        ),
        verticalSpacing(12),

        // Share Prescription Button
        CustomMaterialButton(
          textButton: 'Share Prescription',
          onPressed:
              () => PdfShareHelper.sharePrescriptionText(context, prescription),
          backgroundColor: ColorsManager.primaryColor,
          textColor: Colors.white,
          height: 50.h,
          raduisBorder: 12,
          icon: Iconsax.share,
        ),
        verticalSpacing(12),

        // Contact Doctor Button
        CustomMaterialButton(
          textButton: 'Contact Doctor',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Contact Dr. ${prescription.doctor?.name ?? "Doctor"}',
                ),
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
