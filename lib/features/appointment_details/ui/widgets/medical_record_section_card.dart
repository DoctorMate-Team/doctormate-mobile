import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/section_header_widget.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/section_empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MedicalRecordSectionCard extends StatelessWidget {
  final PatientAppointmentModel appointment;
  final MedicalRecord? medicalRecord;

  const MedicalRecordSectionCard({
    super.key,
    required this.appointment,
    this.medicalRecord,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasMedicalRecord = medicalRecord != null;

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
            icon: Iconsax.document_text_1,
            iconColor: Colors.teal,
            title: 'Medical Record',
            subtitle: 'Clinical notes & assessments',
          ),
          Divider(height: 1, color: Colors.grey[200]),
          // ignore: dead_code
          if (hasMedicalRecord)
            _buildMedicalRecordContent()
          else
            const SectionEmptyStateWidget(
              icon: Iconsax.document_text_1,
              title: 'No Medical Record',
              message: 'Clinical notes will be available after consultation',
            ),
        ],
      ),
    );
  }

  Widget _buildMedicalRecordContent() {
    if (medicalRecord == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Title', medicalRecord!.title),
          SizedBox(height: 12.h),
          _buildDetailRow('Type', medicalRecord!.recordType),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Date',
            '${medicalRecord!.recordDate.day}/${medicalRecord!.recordDate.month}/${medicalRecord!.recordDate.year}',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(label, style: TextStyles.font14GrayRegular),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyles.font14GrayRegular.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
