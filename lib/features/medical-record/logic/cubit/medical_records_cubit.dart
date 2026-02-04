import 'package:doctor_mate/features/medical-record/data/repos/medical_records_repos.dart';
import 'package:doctor_mate/features/medical-record/logic/cubit/medical_records_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalRecordsCubit extends Cubit<MedicalRecordsState> {
  MedicalRecordsCubit(this._medicalRecordsRepos)
    : super(MedicalRecordsState.initial());

  final MedicalRecordsRepos _medicalRecordsRepos;

  void getPatientMedicalRecords({required int page, required int limit}) async {
    emit(MedicalRecordsState.loadingGetMedicalRecords());
    final result = await _medicalRecordsRepos.getMedicalRecords(
      page: page,
      limit: limit,
    );
    result.when(
      success: (response) {
        emit(
          MedicalRecordsState.successGetMedicalRecords(
            medicalRecords: response.data.records,
            hasReachedMax: false,
          ),
        );
      },
      failure: (error) {
        emit(
          MedicalRecordsState.errorGetMedicalRecords(
            message: error.apiErrorModel.message!,
          ),
        );
      },
    );
  }
}
