import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/prescriptions/logic/cubit/prescriptions_cubit.dart';
import 'package:doctor_mate/features/prescriptions/logic/cubit/prescriptions_state.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_action_buttons.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_doctor_card.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_error_state.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_header_card.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_medications_card.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_notes_card.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_patient_card.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_shimmer_loading.dart';
import 'package:doctor_mate/features/prescriptions/ui/widgets/prescription_validity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PrescriptionsScreen extends StatefulWidget {
  final String? diagnosisId;
  final String? appointmentId;
  final String? prescriptionId;

  const PrescriptionsScreen({
    super.key,
    this.diagnosisId,
    this.appointmentId,
    this.prescriptionId,
  });

  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PrescriptionsCubit>().getPrescriptionDetails(
      appointmentId: widget.appointmentId,
      prescriptionId: widget.prescriptionId,
    );
  }

  Color _getStatusColor(String? status) {
    if (status == null) return ColorsManager.gray;

    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'expired':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.orange;
      default:
        return ColorsManager.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Prescription Details',
          style: TextStyles.font18DarkGreenBold,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsManager.darkBlue),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<PrescriptionsCubit, PrescriptionsState>(
        buildWhen:
            (previous, current) =>
                current is LoadingGettingPrescriptionDetails ||
                current is SuccessGettingPrescriptionDetails ||
                current is FailureGettingPrescriptionDetails,
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loadingGettingPrescriptionDetails:
                () => const PrescriptionShimmerLoading(),
            successGettingPrescriptionDetails: (prescription) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrescriptionHeaderCard(
                      prescription: prescription,
                      statusColor: _getStatusColor(
                        prescription.appointment?.status,
                      ),
                    ),
                    verticalSpacing(16),
                    PrescriptionPatientCard(prescription: prescription),
                    verticalSpacing(16),
                    PrescriptionDoctorCard(prescription: prescription),
                    verticalSpacing(16),
                    PrescriptionMedicationsCard(prescription: prescription),
                    verticalSpacing(16),
                    if (prescription.notes != null)
                      PrescriptionNotesCard(prescription: prescription),
                    if (prescription.notes != null) verticalSpacing(16),
                    PrescriptionValidityCard(prescription: prescription),
                    verticalSpacing(24),
                    PrescriptionActionButtons(prescription: prescription),
                    verticalSpacing(16),
                  ],
                ),
              );
            },
            failureGettingPrescriptionDetails:
                (error) => PrescriptionErrorState(
                  error: error,
                  onRetry: () {
                    context.read<PrescriptionsCubit>().getPrescriptionDetails(
                      appointmentId: widget.appointmentId,
                      prescriptionId: widget.prescriptionId,
                    );
                  },
                ),
          );
        },
      ),
    );
  }
}
