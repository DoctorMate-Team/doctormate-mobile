import 'package:doctor_mate/features/booking_appointment/data/models/appointment_request_body.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/initiate_payment_request.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/update_payment_status_request.dart';
import 'package:doctor_mate/features/booking_appointment/data/repos/appointment_repos.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this._appointmentRepos) : super(AppointmentState.initial());
  final AppointmentRepos _appointmentRepos;

  void getAvailableSlots({
    required String doctorId,
    required String date,
  }) async {
    emit(AppointmentState.availableSlotsLoading());
    final result = await _appointmentRepos.getAvailableSlots(
      doctorId: doctorId,
      date: date,
    );
    result.when(
      success: (availableSlotsResponse) {
        emit(
          AppointmentState.availableSlotsLoaded(availableSlotsResponse.data),
        );
      },
      failure: (error) {
        emit(
          AppointmentState.availableSlotsError(
            message: error.apiErrorModel.message!,
          ),
        );
      },
    );
  }

  void bookAppointment({
    required String doctorId,
    required String date,
    required String time,
    required String reason,
    required String appointmentType,
    required String paymentMethod,
  }) async {
    emit(AppointmentState.bookAppointmentLoading());
    final result = await _appointmentRepos.bookAppointment(
      appointmentData: AppointmentRequestBody(
        doctorId: doctorId,
        appointmentDate: date,
        appointmentTime: time,
        reason: reason,
        appointmentType: appointmentType,
        paymentMethod: paymentMethod,
      ),
    );
    result.when(
      success: (appointmentResponseBody) {
        emit(
          AppointmentState.bookAppointmentSuccess(appointmentResponseBody.data),
        );
      },
      failure: (error) {
        emit(
          AppointmentState.bookAppointmentError(
            message: error.apiErrorModel.message!,
          ),
        );
      },
    );
  }

  void initiatePayment({
    required String appointmentId,
    required String provider,
  }) async {
    emit(AppointmentState.initiatePaymentLoading());
    final result = await _appointmentRepos.initiatePayment(
      request: InitiatePaymentRequest(
        appointmentId: appointmentId,
        provider: provider,
      ),
    );
    result.when(
      success: (response) {
        emit(AppointmentState.initiatePaymentSuccess(response.data));
      },
      failure: (error) {
        emit(
          AppointmentState.initiatePaymentError(
            message: error.apiErrorModel.message!,
          ),
        );
      },
    );
  }

  void updatePaymentStatus({
    required String paymentId,
    required String status,
    String? providerRef,
  }) async {
    emit(AppointmentState.updatePaymentStatusLoading());
    final result = await _appointmentRepos.updatePaymentStatus(
      paymentId: paymentId,
      request: UpdatePaymentStatusRequest(
        status: status,
        providerRef: providerRef,
      ),
    );
    result.when(
      success: (_) {
        emit(AppointmentState.updatePaymentStatusSuccess());
      },
      failure: (error) {
        emit(
          AppointmentState.updatePaymentStatusError(
            message:
                error.apiErrorModel.message ??
                'Failed to update payment status',
          ),
        );
      },
    );
  }

  void uploadMedicalImage({
    required String appointmentId,
    required String imagePath,
  }) async {
    emit(AppointmentState.uploadMedicalImageLoading());
    final result = await _appointmentRepos.uploadMedicalImage(
      description: "Medical image uploaded for appointment $appointmentId",
      appointmentId: appointmentId,
      filePath: imagePath,
    );
    result.when(
      success: (_) {
        emit(AppointmentState.uploadMedicalImageSuccess());
      },
      failure: (error) {
        emit(
          AppointmentState.uploadMedicalImageError(
            message: error.apiErrorModel.message!,
          ),
        );
      },
    );
  }
}
