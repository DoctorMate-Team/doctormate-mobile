import 'package:doctor_mate/features/profile/data/models/profile_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';
@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  // Get Profile States
  const factory ProfileState.getProfileLoading() = GetProfileLoading;
  const factory ProfileState.getProfileSuccess(ProfileResponseModel profile) = GetProfileSuccess;
  const factory ProfileState.getProfileError({required String message}) = GetProfileError;

  // Upload Profile Image States
  const factory ProfileState.uploadProfileImageLoading() = UploadProfileImageLoading;
  const factory ProfileState.uploadProfileImageSuccess() = UploadProfileImageSuccess;
  const factory ProfileState.uploadProfileImageError({required String message}) = UploadProfileImageError;

  // Update Profile Details States
  const factory ProfileState.updateProfileDetailsLoading() = UpdateProfileDetailsLoading;
  const factory ProfileState.updateProfileDetailsSuccess() = UpdateProfileDetailsSuccess;
  const factory ProfileState.updateProfileDetailsError({required String message}) = UpdateProfileDetailsError;
}
