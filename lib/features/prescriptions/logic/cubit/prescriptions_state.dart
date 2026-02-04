import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prescriptions_state.freezed.dart';
@freezed
class PrescriptionsState with _$PrescriptionsState {
  const factory PrescriptionsState.initial() = _Initial;

  const factory PrescriptionsState.loadingGettingPrescriptionDetails() =
      LoadingGettingPrescriptionDetails;
  const factory PrescriptionsState.successGettingPrescriptionDetails(
      PrescriptionDetailsResponse prescriptionDetails
  ) =
      SuccessGettingPrescriptionDetails;
  const factory PrescriptionsState.failureGettingPrescriptionDetails(String errorMessage) =
      FailureGettingPrescriptionDetails;
}
