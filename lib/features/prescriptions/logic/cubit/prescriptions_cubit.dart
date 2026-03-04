import 'package:doctor_mate/features/prescriptions/data/repos/prescriptions_repos.dart';
import 'package:doctor_mate/features/prescriptions/logic/cubit/prescriptions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrescriptionsCubit extends Cubit<PrescriptionsState> {
  PrescriptionsCubit(this._prescriptionsRepos)
    : super(PrescriptionsState.initial());
  final PrescriptionsRepos _prescriptionsRepos;

  void getPrescriptionDetails({
    String? appointmentId,
    String? prescriptionId,
  }) async {
    emit(PrescriptionsState.loadingGettingPrescriptionDetails());
    final result = await _prescriptionsRepos.getPrescriptionDetails(
      appointmentId: appointmentId,
      prescriptionId: prescriptionId,
    );
    result.when(
      success: (response) {
        emit(
          PrescriptionsState.successGettingPrescriptionDetails(response.data),
        );
      },
      failure: (error) {
        emit(
          PrescriptionsState.failureGettingPrescriptionDetails(
            error.apiErrorModel.message!,
          ),
        );
      },
    );
  }
}
