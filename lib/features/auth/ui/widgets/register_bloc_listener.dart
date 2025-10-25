import 'package:doctor_mate/core/functions/custom_loading_dialog.dart';
import 'package:doctor_mate/core/functions/custom_show_dialog.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is RegisterLoading ||
              current is RegisterError ||
              current is RegisterSuccess,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          registerLoading: () {
            customLoadingDialog(
              context,
              title: 'Registering...',
              subtitle: 'Please wait...',
            );
          },
          registerError: (error) {
            context.pop();
            showCustomDialog(
              context,
              subtitle: error,
              title: "Register Failed",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () => context.pop(),
                ),
              ],
            );
          },
          registerSuccess: (result) {
            context.pop();
            showCustomDialog(
              context,
              subtitle: "Go to login page to login",
              title: "Register Success",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () => context.pop(),
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
