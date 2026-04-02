import 'package:doctor_mate/features/booking_appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/available_slots_response.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/initiate_payment_response.dart';
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

  // Initiate Payment States
  const factory AppointmentState.initiatePaymentLoading() =
      InitiatePaymentLoading;
  const factory AppointmentState.initiatePaymentSuccess(
    InitiatePaymentResponse response,
  ) = InitiatePaymentSuccess;
  const factory AppointmentState.initiatePaymentError({
    required String message,
  }) = InitiatePaymentError;

  // Update Payment Status States
  const factory AppointmentState.updatePaymentStatusLoading() =
      UpdatePaymentStatusLoading;
  const factory AppointmentState.updatePaymentStatusSuccess() =
      UpdatePaymentStatusSuccess;
  const factory AppointmentState.updatePaymentStatusError({
    required String message,
  }) = UpdatePaymentStatusError;

  // Upload Medical Image States
  const factory AppointmentState.uploadMedicalImageLoading() =
      UploadMedicalImageLoading;
  const factory AppointmentState.uploadMedicalImageSuccess() =
      UploadMedicalImageSuccess;
  const factory AppointmentState.uploadMedicalImageError({
    required String message,
  }) = UploadMedicalImageError;
}
