import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/section_header_widget.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/section_empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PrescriptionSectionCard extends StatelessWidget {
  final PatientAppointmentModel appointment;
  final List<Prescription> prescriptions;

  const PrescriptionSectionCard({
    super.key,
    required this.appointment,
    this.prescriptions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final bool hasPrescription = prescriptions.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SectionHeaderWidget(
            icon: Iconsax.clipboard_text,
            iconColor: Colors.blue,
            title: 'Prescription',
            subtitle: 'Prescribed medications & dosage',
          ),
          Divider(height: 1, color: Colors.grey[200]),
          // ignore: dead_code
          if (hasPrescription)
            // ignore: dead_code
            _buildPrescriptionContent()
          else
            const SectionEmptyStateWidget(
              icon: Iconsax.clipboard_text,
              title: 'No Prescription',
              message: 'Prescription will be available after consultation',
            ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionContent() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < prescriptions.length; i++)
            ..._buildPrescriptionSection(prescriptions[i], i),
        ],
      ),
    );
  }

  List<Widget> _buildPrescriptionSection(Prescription prescription, int index) {
    return [
      if (index > 0) ...[verticalSpacing(16), Divider(color: Colors.grey[300])],
      if (prescription.notes != null) ...[
        if (index > 0) verticalSpacing(16),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.amber.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Iconsax.note_1, size: 16.sp, color: Colors.amber[700]),
              horizantialSpacing(8),
              Expanded(
                child: Text(
                  prescription.notes!,
                  style: TextStyles.font12GrayRegular.copyWith(
                    color: Colors.amber[900],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpacing(12),
      ],
      ...prescription.medications.map((medication) {
        final isLast = medication == prescription.medications.last;
        return Column(
          children: [
            _buildMedicationItem(medication: medication),
            if (!isLast) verticalSpacing(12),
          ],
        );
      }).toList(),
    ];
  }

  Widget _buildMedicationItem({required Medication medication}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.health, size: 20.sp, color: Colors.blue),
              horizantialSpacing(8),
              Expanded(
                child: Text(
                  medication.drugName,
                  style: TextStyles.font16DarkGreenBold.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  medication.dosage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeightHelper.bold,
                  ),
                ),
              ),
            ],
          ),
          verticalSpacing(8),
          Divider(height: 1, color: Colors.grey[300]),
          verticalSpacing(8),
          _buildMedicationDetail(
            icon: Iconsax.clock,
            label: 'Frequency',
            value: medication.frequency,
          ),
          verticalSpacing(6),
          _buildMedicationDetail(
            icon: Iconsax.calendar,
            label: 'Duration',
            value: '${medication.durationDays} days',
          ),
          verticalSpacing(6),
          _buildMedicationDetail(
            icon: Iconsax.info_circle,
            label: 'Instructions',
            value: medication.instructions,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationDetail({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey),
        horizantialSpacing(6),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeightHelper.medium,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}
