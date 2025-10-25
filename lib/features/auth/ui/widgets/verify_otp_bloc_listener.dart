import 'package:doctor_mate/core/functions/custom_loading_dialog.dart';
import 'package:doctor_mate/core/functions/custom_show_dialog.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpBlocListener extends StatelessWidget {
  const VerifyOtpBlocListener({super.key, required this.isForgetPass});
  final bool isForgetPass;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is VerifyOtpLoading ||
              current is VerifyOtpError ||
              current is VerifyOtpSuccess,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          verifyOtpLoading: () {
            customLoadingDialog(
              context,
              title: 'Verifying OTP',
              subtitle: 'Please wait...',
            );
          },
          verifyOtpError: (error) {
            context.pop();
            showCustomDialog(
              context,
              subtitle: error,
              title: "OTP Verification Failed",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () => context.pop(),
                ),
              ],
            );
          },
          verifyOtpSuccess: () {
            context.pop();
            if (isForgetPass) {
              context.goNamed(
                Routes.resetPassword,
                extra: {
                  'email': context.read<AuthCubit>().emailController.text,
                },
              );
            } else {
              context.goNamed(Routes.completeProfile);
            }
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
