import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/auth/ui/widgets/login_buttons.dart';
import 'package:doctor_mate/features/auth/ui/widgets/login_form.dart';
import 'package:doctor_mate/features/auth/ui/widgets/signup_form.dart';
import 'package:doctor_mate/features/auth/ui/widgets/terms_and_conditions_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthSwitchButtons extends StatefulWidget {
  const AuthSwitchButtons({super.key});

  @override
  State<AuthSwitchButtons> createState() => _AuthSwitchButtonsState();
}

class _AuthSwitchButtonsState extends State<AuthSwitchButtons>
    with TickerProviderStateMixin {
  bool isLogin = true;
  late AnimationController _formController;
  late Animation<double> _formFadeAnimation;
  late Animation<Offset> _formSlideAnimation;

  @override
  void initState() {
    super.initState();
    _formController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _formFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _formController, curve: Curves.easeInOut),
    );

    _formSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _formController, curve: Curves.easeOutBack),
    );

    // Start with form visible
    _formController.forward();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  void _switchForm(bool newIsLogin) {
    if (newIsLogin != isLogin) {
      _formController.reverse().then((_) {
        setState(() {
          isLogin = newIsLogin;
        });
        _formController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _switchForm(true),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color:
                          isLogin
                              ? ColorsManager.primaryColor
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow:
                          isLogin
                              ? [
                                BoxShadow(
                                  color: ColorsManager.primaryColor.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                              : [],
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isLogin ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _switchForm(false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color:
                          !isLogin
                              ? ColorsManager.primaryColor
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow:
                          !isLogin
                              ? [
                                BoxShadow(
                                  color: ColorsManager.primaryColor.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                              : [],
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: !isLogin ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Animated form content
        verticalSpacing(16),
        AnimatedBuilder(
          animation: _formController,
          builder: (context, child) {
            return SlideTransition(
              position: _formSlideAnimation,
              child: FadeTransition(
                opacity: _formFadeAnimation,
                child: Column(
                  children: [
                    isLogin ? const LoginForm() : const SignUpForm(),
                    verticalSpacing(16),
                    isLogin
                        ? const LoginButtons()
                        : CustomMaterialButton(
                          textButton: "Sign Up",
                          onPressed: () {
                            validateRegister(context.read<AuthCubit>());
                          },
                        ),
                    verticalSpacing(16),
                    const TermsAndConditionsText(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void validateRegister(AuthCubit authCubit) {
    if (authCubit.formKey.currentState!.validate()) {
      authCubit.register();
    }
  }
}
