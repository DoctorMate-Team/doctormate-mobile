import 'package:doctor_mate/features/auth/data/models/login_response_model.dart';
import 'package:doctor_mate/features/auth/data/models/register_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  //Login
  const factory AuthState.loginLoading() = LoginLoading;
  const factory AuthState.loginSuccess(LoginResponseModel loginResponse) =
      LoginSuccess;
  const factory AuthState.loginError({required String message}) = LoginError;

  //Register
  const factory AuthState.registerLoading() = RegisterLoading;
  const factory AuthState.registerSuccess(
    RegisterResponseModel registerResponse,
  ) = RegisterSuccess;
  const factory AuthState.registerError({required String message}) =
      RegisterError;

  //Complete Profile
  const factory AuthState.completeProfileLoading() = CompleteProfileLoading;
  const factory AuthState.completeProfileSuccess() = CompleteProfileSuccess;
  const factory AuthState.completeProfileError({required String message}) =
      CompleteProfileError;

  //Send OTP
  const factory AuthState.sendOtpLoading() = SendOtpLoading;
  const factory AuthState.sendOtpSuccess() = SendOtpSuccess;
  const factory AuthState.sendOtpError({required String message}) =
      SendOtpError;

  //Reset Password
  const factory AuthState.resetPasswordLoading() = ResetPasswordLoading;
  const factory AuthState.resetPasswordSuccess() = ResetPasswordSuccess;
  const factory AuthState.resetPasswordError({required String message}) =
      ResetPasswordError;

  //Verify OTP
  const factory AuthState.verifyOtpLoading() = VerifyOtpLoading;
  const factory AuthState.verifyOtpSuccess() = VerifyOtpSuccess;
  const factory AuthState.verifyOtpError({required String message}) =
      VerifyOtpError;

  //Upload Profile Image
  const factory AuthState.uploadProfileImageLoading() =
      UploadProfileImageLoading;
  const factory AuthState.uploadProfileImageSuccess() =
      UploadProfileImageSuccess;
  const factory AuthState.uploadProfileImageError({required String message}) =
      UploadProfileImageError;
}
