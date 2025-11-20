import 'package:doctor_mate/features/details/data/repos/details_repos.dart';
import 'package:doctor_mate/features/details/logic/cubit/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._detailsRepos) : super(DetailsState.initial());
  final DetailsRepos _detailsRepos;

  void getDoctorDetails({required String doctorId}) async {
    emit(DetailsState.getDoctorDetailsLoading());
    final result = await _detailsRepos.getDoctorDetails(doctorId: doctorId);
    result.when(
      success: (response) {
        emit(DetailsState.getDoctorDetailsSuccess(doctorDetails: response.data));
      },
      failure: (error) {
        emit(
          DetailsState.getDoctorDetailsError(message: error.apiErrorModel.message!),
        );
      },
    );
  }
}
