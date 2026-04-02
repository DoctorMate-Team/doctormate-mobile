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
        if (!isClosed) emit(ProfileState.getProfileSuccess(response.data));
      },
      failure: (error) {
        if (!isClosed) {
          emit(
            ProfileState.getProfileError(message: error.apiErrorModel.message!),
          );
        }
      },
    );
  }

  void uploadProfileImage({required String imagePath}) async {
    emit(ProfileState.uploadProfileImageLoading());
    final result = await _profileRepos.uploadProfileImage(imagePath: imagePath);
    result.when(
      success: (response) {
        if (!isClosed) emit(ProfileState.uploadProfileImageSuccess());
      },
      failure: (error) {
        if (!isClosed) {
          emit(
            ProfileState.uploadProfileImageError(
              message: error.apiErrorModel.message!,
            ),
          );
        }
      },
    );
  }

  void updateProfileDetails({
    required String fullName,
    required String phoneNumber,
    required String address,
    String? imagePath,
  }) async {
    emit(ProfileState.updateProfileDetailsLoading());
    final result = await _profileRepos.updateProfileDetails(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
      imagePath: imagePath,
    );
    result.when(
      success: (_) {
        if (!isClosed) {
          emit(ProfileState.updateProfileDetailsSuccess());
          // Automatically refresh profile data after successful update
          getProfile();
        }
      },
      failure: (error) {
        if (!isClosed) {
          emit(
            ProfileState.updateProfileDetailsError(
              message: error.apiErrorModel.message!,
            ),
          );
        }
      },
    );
  }
}
