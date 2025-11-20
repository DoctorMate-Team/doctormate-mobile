import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_state.freezed.dart';
@freezed
class DetailsState with _$DetailsState {
  const factory DetailsState.initial() = _Initial;

  // Getting Doctor Details
  const factory DetailsState.getDoctorDetailsLoading() = _GetDoctorDetailsLoading;
  const factory DetailsState.getDoctorDetailsSuccess({required DoctorDetailsModel doctorDetails}) =
      _GetDoctorDetailsSuccess;
  const factory DetailsState.getDoctorDetailsError({required String message}) = _GetDoctorDetailsError;
}
