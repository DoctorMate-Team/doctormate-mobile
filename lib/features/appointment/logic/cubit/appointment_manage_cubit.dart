import 'package:doctor_mate/features/appointment/data/repos/appointment_manage_repos.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentManageCubit extends Cubit<AppointmentManageState> {
  AppointmentManageCubit(this._appointmentManageRepos) : super(AppointmentManageState.initial());
  final AppointmentManageRepos _appointmentManageRepos;

  Future<void> getPatientAppointments({required int page, required int limit, String? status}) async {
    emit(AppointmentManageState.loadingAppointmentsPatient());
    final result = await _appointmentManageRepos.getPatientAppointments(page: page, limit: limit, status: status);
    result.when(
      success: (response) {
        emit(AppointmentManageState.loadedAppointmentsPatient(response.data));
      },
      failure: (error) {
        emit(AppointmentManageState.errorAppointmentsPatient(message: error.apiErrorModel.message!));
      },
    );
  }

  Future<void> updateAppointmentStatus({required String appointmentId}) async {
    emit(AppointmentManageState.updatingAppointmentStatus());
    final result = await _appointmentManageRepos.updateAppointmentStatus(appointmentId: appointmentId);
    result.when(
      success: (_) {
        emit(AppointmentManageState.updatedAppointmentStatus());
      },
      failure: (error) {
        emit(AppointmentManageState.errorUpdatingAppointmentStatus(message: error.apiErrorModel.message!));
      },
    );
  }
}
