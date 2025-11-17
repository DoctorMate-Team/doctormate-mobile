import 'package:doctor_mate/core/functions/custom_loading_dialog.dart';
import 'package:doctor_mate/core/functions/custom_show_dialog.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UploadProfileImageBlocListener extends StatelessWidget {
  const UploadProfileImageBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is UploadProfileImageLoading ||
              current is UploadProfileImageSuccess ||
              current is UploadProfileImageError,
      listener: (context, state) {
        state.whenOrNull(
          uploadProfileImageLoading: () {
            customLoadingDialog(
              context,
              title: 'Uploading Image',
              subtitle: 'Please wait...',
            );
          },
          uploadProfileImageSuccess: () {
            context.pop(); // Close loading dialog
            showCustomDialog(
              context,
              title: "Success",
              subtitle: "Profile image uploaded successfully!",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () => context.pop(),
                ),
              ],
            );
          },
          uploadProfileImageError: (message) {
            context.pop(); // Close loading dialog
            showCustomDialog(
              context,
              subtitle: message,
              title: "Upload Failed",
              actions: [
                CustomMaterialButton(
                  textButton: "Try Again",
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
