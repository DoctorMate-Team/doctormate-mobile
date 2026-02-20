import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_details_state.freezed.dart';

@freezed
class AppointmentDetailsState with _$AppointmentDetailsState {
  const factory AppointmentDetailsState.initial() = _Initial;

  const factory AppointmentDetailsState.getAppointmentDetailsLoading() =
      GetAppointmentDetailsLoading;
  const factory AppointmentDetailsState.getAppointmentDetailsSuccess({
    required AppointmentDetailsResponse appointmentDetails,
  }) = GetAppointmentDetailsSuccess;
  const factory AppointmentDetailsState.getAppointmentDetailsError({
    required String message,
  }) = GetAppointmentDetailsError;
}
