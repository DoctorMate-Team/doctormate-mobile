import 'package:doctor_mate/features/appointment_details/data/repos/appointment_details_repos.dart';
import 'package:doctor_mate/features/appointment_details/logic/cubit/appointment_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentDetailsCubit extends Cubit<AppointmentDetailsState> {
  AppointmentDetailsCubit(this._appointmentDetailsRepos)
    : super(AppointmentDetailsState.initial());
  final AppointmentDetailsRepos _appointmentDetailsRepos;

  void getAppointmentDetails(String appointmentId) async {
    emit(const AppointmentDetailsState.getAppointmentDetailsLoading());
    final result = await _appointmentDetailsRepos.getAppointmentDetails(
      appointmentId,
    );
    result.when(
      success:
          (response) => emit(
            AppointmentDetailsState.getAppointmentDetailsSuccess(
              appointmentDetails: response.data,
            ),
          ),
      failure:
          (error) => emit(
            AppointmentDetailsState.getAppointmentDetailsError(
              message:
                  error.apiErrorModel.message ??
                  'Failed to load appointment details',
            ),
          ),
    );
  }
}
