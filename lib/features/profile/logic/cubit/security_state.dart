import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_state.freezed.dart';

@freezed
class SecurityState with _$SecurityState {
  const factory SecurityState.initial() = _Initial;

  // Change Password States
  const factory SecurityState.changePasswordLoading() = ChangePasswordLoading;
  const factory SecurityState.changePasswordSuccess() = ChangePasswordSuccess;
  const factory SecurityState.changePasswordError({required String message}) =
      ChangePasswordError;
}
