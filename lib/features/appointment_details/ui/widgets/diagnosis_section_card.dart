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

class DiagnosisSectionCard extends StatelessWidget {
  final PatientAppointmentModel appointment;
  final List<Diagnosis> diagnoses;

  const DiagnosisSectionCard({
    super.key,
    required this.appointment,
    this.diagnoses = const [],
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDiagnosis = diagnoses.isNotEmpty;

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
            icon: Iconsax.health,
            iconColor: Colors.red,
            title: 'Diagnosis',
            subtitle: 'Medical conditions & assessments',
          ),
          Divider(height: 1, color: Colors.grey[200]),
          // ignore: dead_code
          if (hasDiagnosis)
            _buildDiagnosisContent()
          else
            const SectionEmptyStateWidget(
              icon: Iconsax.health,
              title: 'No Diagnosis',
              message:
                  'Diagnosis details will be available after doctor assessment',
            ),
        ],
      ),
    );
  }

  Widget _buildDiagnosisContent() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < diagnoses.length; i++) ...[
            _buildDiagnosisItem(diagnosis: diagnoses[i]),
            if (i < diagnoses.length - 1) verticalSpacing(12),
          ],
        ],
      ),
    );
  }

  Widget _buildDiagnosisItem({required Diagnosis diagnosis}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  diagnosis.icdCode,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeightHelper.bold,
                  ),
                ),
              ),
              horizantialSpacing(8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getSeverityColor(diagnosis.severity).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(
                    color: _getSeverityColor(
                      diagnosis.severity,
                    ).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  diagnosis.severity,
                  style: TextStyle(
                    color: _getSeverityColor(diagnosis.severity),
                    fontSize: 11.sp,
                    fontWeight: FontWeightHelper.medium,
                  ),
                ),
              ),
            ],
          ),
          verticalSpacing(8),
          Text(
            diagnosis.description,
            style: TextStyles.font14GrayRegular.copyWith(color: Colors.black),
          ),
          if (diagnosis.doctorName != null) ...[
            verticalSpacing(6),
            Text(
              'Diagnosed by: ${diagnosis.doctorName}',
              style: TextStyles.font12GrayRegular.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'severe':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
