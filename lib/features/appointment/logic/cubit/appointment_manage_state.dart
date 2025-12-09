import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_manage_state.freezed.dart';
@freezed
class AppointmentManageState with _$AppointmentManageState {
  const factory AppointmentManageState.initial() = _Initial;

  // Get All Appointments Patient
  const factory AppointmentManageState.loadingAppointmentsPatient() =
      LoadingAppointmentsPatient;
  const factory AppointmentManageState.loadedAppointmentsPatient(AppointmentListResponse appointmentListResponse) = LoadedAppointmentsPatient;
  const factory AppointmentManageState.errorAppointmentsPatient({
    required String message,
  }) = ErrorAppointmentsPatient;

  // Update Appointment Status
  const factory AppointmentManageState.updatingAppointmentStatus() =
      UpdatingAppointmentStatus;
  const factory AppointmentManageState.updatedAppointmentStatus() =
      UpdatedAppointmentStatus;
  const factory AppointmentManageState.errorUpdatingAppointmentStatus({
    required String message,
  }) = ErrorUpdatingAppointmentStatus;
}
