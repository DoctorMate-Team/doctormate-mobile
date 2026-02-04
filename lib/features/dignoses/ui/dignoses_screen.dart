import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/dignoses/ui/widgets/diagnosis_action_buttons.dart';
import 'package:doctor_mate/features/dignoses/ui/widgets/diagnosis_details_card.dart';
import 'package:doctor_mate/features/dignoses/ui/widgets/diagnosis_header_card.dart';
import 'package:doctor_mate/features/dignoses/ui/widgets/diagnosis_no_data_state.dart';
import 'package:doctor_mate/features/dignoses/ui/widgets/doctor_info_card.dart';
import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DiagnosesScreen extends StatefulWidget {
  final String recordId;
  final DiagnosisModel? diagnosisData;

  const DiagnosesScreen({
    super.key,
    required this.recordId,
    this.diagnosisData,
  });

  @override
  State<DiagnosesScreen> createState() => _DiagnosesScreenState();
}

class _DiagnosesScreenState extends State<DiagnosesScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: If needed, fetch additional details from API using widget.recordId
  }

  Color _getSeverityColor() {
    if (widget.diagnosisData == null) return ColorsManager.gray;

    switch (widget.diagnosisData!.severity.toLowerCase()) {
      case 'mild':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'severe':
        return Colors.red;
      case 'critical':
        return Colors.red.shade900;
      default:
        return ColorsManager.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('Diagnosis Details', style: TextStyles.font18DarkGreenBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsManager.darkBlue),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.printer,
              color: ColorsManager.darkBlue,
              size: 24.sp,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Print functionality coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Iconsax.share,
              color: ColorsManager.darkBlue,
              size: 24.sp,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Share functionality coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body:
          widget.diagnosisData == null
              ? const DiagnosisNoDataState()
              : SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DiagnosisHeaderCard(
                      diagnosis: widget.diagnosisData!,
                      severityColor: _getSeverityColor(),
                    ),
                    verticalSpacing(16),
                    DiagnosisDetailsCard(diagnosis: widget.diagnosisData!),
                    verticalSpacing(16),
                    DoctorInfoCard(diagnosis: widget.diagnosisData!),
                    verticalSpacing(24),
                    DiagnosisActionButtons(diagnosis: widget.diagnosisData!),
                    verticalSpacing(16),
                  ],
                ),
              ),
    );
  }
}
