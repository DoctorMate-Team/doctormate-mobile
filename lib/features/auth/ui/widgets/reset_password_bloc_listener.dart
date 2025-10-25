import 'package:doctor_mate/core/functions/custom_loading_dialog.dart';
import 'package:doctor_mate/core/functions/custom_show_dialog.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is ResetPasswordLoading ||
              current is ResetPasswordError ||
              current is ResetPasswordSuccess,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          resetPasswordLoading: () {
            customLoadingDialog(
              context,
              title: 'Resetting Password',
              subtitle: 'Please wait...',
            );
          },
          resetPasswordError: (error) {
            context.pop();
            showCustomDialog(
              context,
              subtitle: error,
              title: "Password Reset Failed",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () => context.pop(),
                ),
              ],
            );
          },
          resetPasswordSuccess: () {
            context.pop();
            showCustomDialog(
              context,
              title: "Password Reset Successful",
              subtitle:
                  "Your password has been reset successfully. Please log in with your new password.",
              actions: [
                CustomMaterialButton(
                  textButton: "Go to Login",
                  onPressed: () {
                    context.goNamed(Routes.auth);
                  },
                ),
              ],
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
