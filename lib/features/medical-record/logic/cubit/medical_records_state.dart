import 'package:doctor_mate/features/medical-record/data/models/medical_record_list_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'medical_records_state.freezed.dart';
@freezed
class MedicalRecordsState with _$MedicalRecordsState {
  const factory MedicalRecordsState.initial() = _Initial;

  const factory MedicalRecordsState.loadingGetMedicalRecords() =
      LoadingGetMedicalRecords;

  const factory MedicalRecordsState.successGetMedicalRecords({
    required List<MedicalRecordModel> medicalRecords,
    required bool hasReachedMax,
  }) = SuccessGetMedicalRecords;

  const factory MedicalRecordsState.errorGetMedicalRecords({
    required String message,
  }) = ErrorGetMedicalRecords;
}
