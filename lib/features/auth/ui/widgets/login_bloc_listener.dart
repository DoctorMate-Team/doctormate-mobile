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

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen:
          (previous, current) =>
              current is LoginLoading ||
              current is LoginError ||
              current is LoginSuccess,
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loginLoading: () {
            customLoadingDialog(
              context,
              title: 'Logging In',
              subtitle: 'Please wait...',
            );
          },
          loginError: (error) {
            context.pop();
            showCustomDialog(
              context,
              subtitle: error,
              title: "Login Failed",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () => context.pop(),
                ),
              ],
            );
          },
          loginSuccess: (result) {
            context.pop();
            showCustomDialog(
              context,
              subtitle: "Welcome, ${result.user.fullName}",
              title: "Login Success",
              actions: [
                CustomMaterialButton(
                  textButton: "Continue",
                  onPressed: () async {
                    if (result.user.isCompletedProfile &&
                        result.user.isVerified) {
                      await CacheHelper.setSecuredValue(
                        AppConstants.userToken,
                        result.token,
                      );
                      context.goNamed(Routes.home);
                    } else if (!result.user.isCompletedProfile &&
                        result.user.isVerified) {
                      context.goNamed(Routes.completeProfile);
                    } else if (!result.user.isVerified) {
                      context.read<AuthCubit>().sendOtp(isForgetPass: false);
                      context.goNamed(
                        Routes.otpScreen,
                        extra: {
                          'email': result.user.email,
                          'isForgetPass': false,
                        },
                      );
                    }
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
