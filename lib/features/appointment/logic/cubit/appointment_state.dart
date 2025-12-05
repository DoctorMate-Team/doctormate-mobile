import 'package:doctor_mate/features/appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/appointment/data/models/available_slots_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_state.freezed.dart';

@freezed
class AppointmentState with _$AppointmentState {
  const factory AppointmentState.initial() = _Initial;

  // Available Slots States
  const factory AppointmentState.availableSlotsLoading() =
      AvailableSlotsLoading;
  const factory AppointmentState.availableSlotsLoaded(
    AvailableSlotsResponse availableSlotsResponse,
  ) = AvailableSlotsLoaded;
  const factory AppointmentState.availableSlotsError({
    required String message,
  }) = AvailableSlotsError;

  // Booking Appointment States
  const factory AppointmentState.bookAppointmentLoading() =
      BookAppointmentLoading;
  const factory AppointmentState.bookAppointmentSuccess(
    AppointmentResponseBody appointmentResponseBody,
  ) = BookAppointmentSuccess;
  const factory AppointmentState.bookAppointmentError({
    required String message,
  }) = BookAppointmentError;
}
