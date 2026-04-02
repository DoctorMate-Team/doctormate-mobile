import 'package:doctor_mate/features/smart-checkup/data/repos/smart_checkup_repos.dart';
import 'package:doctor_mate/features/smart-checkup/logic/cubit/smart_checkup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmartCheckupCubit extends Cubit<SmartCheckupState> {
  SmartCheckupCubit(this._smartCheckupRepos)
    : super(SmartCheckupState.initial());
  final SmartCheckupRepos _smartCheckupRepos;

  Future<void> performSkinCheckup(String imagePath) async {
    emit(const SmartCheckupState.skinCheckupLoading());
    final result = await _smartCheckupRepos.performSkinCheckup(imagePath);
    result.when(
      success:
          (response) =>
              emit(SmartCheckupState.skinCheckupSuccess(response.data)),
      failure:
          (error) => emit(
            SmartCheckupState.skinCheckupFailure(error.apiErrorModel.message!),
          ),
    );
  }

  Future<void> performSymptomCheckup(String symptoms) async {
    emit(const SmartCheckupState.symptomCheckupLoading());
    final result = await _smartCheckupRepos.performSymptomCheckup(
      symptoms: symptoms,
    );
    result.when(
      success:
          (response) =>
              emit(SmartCheckupState.symptomCheckupSuccess(response.data)),
      failure:
          (error) => emit(
            SmartCheckupState.symptomCheckupFailure(
              error.apiErrorModel.message!,
            ),
          ),
    );
  }
}
