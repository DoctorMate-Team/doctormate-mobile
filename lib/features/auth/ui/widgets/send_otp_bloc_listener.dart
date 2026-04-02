import 'package:doctor_mate/core/functions/custom_loading_dialog.dart';
import 'package:doctor_mate/core/functions/custom_show_dialog.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SendOtpBlocListener extends StatelessWidget {
  const SendOtpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is SendOtpLoading ||
              current is SendOtpSuccess ||
              current is SendOtpError,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          sendOtpLoading: () {
            customLoadingDialog(
              context,
              title: 'Sending OTP',
              subtitle: 'Please wait...',
            );
          },
          sendOtpError: (error) {
            context.pop();
            showCustomDialog(
              context,
              subtitle: error,
              title: "OTP Failed",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () => context.pop(),
                ),
              ],
            );
          },
          sendOtpSuccess: () {
            // Capture the AuthCubit before popping the context
            final authCubit = context.read<AuthCubit>();
            context.pop();
            showCustomDialog(
              context,
              subtitle: "OTP sent successfully",
              title: "OTP Sent",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () {
                    context.pop(); // Close the dialog
                    context.goNamed(
                      Routes.otpScreen,
                      extra: {
                        "email": authCubit.emailController.text,
                        "isForgetPass": true,
                      },
                    );
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
