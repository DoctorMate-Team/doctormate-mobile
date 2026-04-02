import 'package:doctor_mate/features/profile/logic/cubit/security_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit() : super(const SecurityState.initial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(const SecurityState.changePasswordLoading());

    try {
      // TODO: Implement actual API call when backend is ready
      // Simulating API call
      await Future.delayed(const Duration(seconds: 2));

      // For now, just return success
      // In production, replace with:
      // final result = await _authRepos.changePassword(
      //   currentPassword: currentPassword,
      //   newPassword: newPassword,
      // );
      // result.when(
      //   success: (_) => emit(const SecurityState.changePasswordSuccess()),
      //   failure: (error) => emit(SecurityState.changePasswordError(
      //     message: error.apiErrorModel.message!,
      //   )),
      // );

      if (!isClosed) {
        emit(const SecurityState.changePasswordSuccess());
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          SecurityState.changePasswordError(
            message: 'Failed to change password: ${e.toString()}',
          ),
        );
      }
    }
  }
}
