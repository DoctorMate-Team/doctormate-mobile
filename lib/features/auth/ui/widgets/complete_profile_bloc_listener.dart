import 'package:doctor_mate/core/functions/custom_loading_dialog.dart';
import 'package:doctor_mate/core/functions/custom_show_dialog.dart';
import 'package:doctor_mate/core/helper/cache_helper.dart';
import 'package:doctor_mate/core/helper/constants.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileBlocListener extends StatelessWidget {
  const CompleteProfileBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is CompleteProfileLoading ||
              current is CompleteProfileError ||
              current is CompleteProfileSuccess,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          completeProfileLoading: () {
            customLoadingDialog(
              context,
              title: 'Completing Profile',
              subtitle: 'Please wait...',
            );
          },
          completeProfileError: (error) {
            context.pop();
            showCustomDialog(
              context,
              subtitle: error,
              title: "Profile Completion Failed",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () => context.pop(),
                ),
              ],
            );
          },
          completeProfileSuccess: () {
            context.pop();
            showCustomDialog(
              context,
              title: "Profile Completed Successfully",
              subtitle: "Your profile has been completed successfully!",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () async {
                    await CacheHelper.setSecuredValue(
                      AppConstants.tokenKey,
                      AppConstants.userTokenProvider,
                    );
                    context.goNamed(
                      Routes.mainLayout,
                    ); // Navigate to main app or dashboard
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
