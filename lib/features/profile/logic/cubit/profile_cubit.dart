import 'package:doctor_mate/features/profile/data/repos/profile_repos.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepos) : super(ProfileState.initial());
  final ProfileRepos _profileRepos;

  void getProfile() async {
    emit(ProfileState.getProfileLoading());
    final result = await _profileRepos.getProfile();
    result.when(
      success: (response) {
        emit(ProfileState.getProfileSuccess(response.data));
      },
      failure: (error) {
        emit(
          ProfileState.getProfileError(message: error.apiErrorModel.message!),
        );
      },
    );
  }

  void uploadProfileImage({required String imagePath}) async {
    emit(ProfileState.uploadProfileImageLoading());
    final result = await _profileRepos.uploadProfileImage(imagePath: imagePath);
    result.when(
      success: (response) {
        emit(ProfileState.uploadProfileImageSuccess());
      },
      failure: (error) {
        emit(
          ProfileState.uploadProfileImageError(
            message: error.apiErrorModel.message!,
          ),
        );
      },
    );
  }
}
