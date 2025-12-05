import 'package:doctor_mate/features/appointment/data/models/appointment_request_body.dart';
import 'package:doctor_mate/features/appointment/data/repos/appointment_repos.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_state.dart';
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
          AppointmentState.availableSlotsLoaded(
            availableSlotsResponse.data,
          ),
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
  }) async {
    emit(AppointmentState.bookAppointmentLoading());
    final result = await _appointmentRepos.bookAppointment(
      appointmentData: AppointmentRequestBody(
        doctorId: doctorId,
        appointmentDate: date,
        appointmentTime: time,
        reason: reason,
        appointmentType: appointmentType,
      ),
    );
    result.when(
      success: (appointmentResponseBody) {
        emit(
          AppointmentState.bookAppointmentSuccess(
            appointmentResponseBody.data,
          ),
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
}
