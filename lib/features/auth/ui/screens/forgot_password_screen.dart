import 'package:doctor_mate/core/helper/app_regex.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/auth/ui/widgets/auth_header.dart';
import 'package:doctor_mate/features/auth/ui/widgets/send_otp_bloc_listener.dart';
import 'package:doctor_mate/features/auth/ui/widgets/terms_and_conditions_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _contentController;

  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<double> _contentFadeAnimation;
  late Animation<Offset> _contentSlideAnimation;

  @override
  void initState() {
    context.read<AuthCubit>().emailController.text = '';

    super.initState();

    // Initialize animation controllers
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Setup header animations
    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeInOut),
    );

    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutBack),
    );

    // Setup content animations
    _contentFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeInOut),
    );

    _contentSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutBack),
    );

    // Start animations with staggered timing
    _startAnimations();
  }

  void _startAnimations() async {
    // Start header animation immediately
    _headerController.forward();

    // Wait then start content animation
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      _contentController.forward();
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authCubit = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: ColorsManager.primaryColor,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomMaterialButton(
                  textButton: "Send OTP",
                  onPressed: () {
                    validateForgotPassword(authCubit);
                  },
                ),
                verticalSpacing(16),
                const TermsAndConditionsText(),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
          child: Form(
            key: authCubit.formKey,
            child: Column(
              children: [
                // Animated Header
                AnimatedBuilder(
                  animation: _headerController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _headerSlideAnimation,
                      child: FadeTransition(
                        opacity: _headerFadeAnimation,
                        child: const AuthHeader(isBack: true),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: AnimatedBuilder(
                      animation: _contentController,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _contentSlideAnimation,
                          child: FadeTransition(
                            opacity: _contentFadeAnimation,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Forgot password?",
                                    style: TextStyles.font20GreenBold,
                                  ),
                                  verticalSpacing(24),
                                  Text(
                                    "Enter your email and we'll send a 6-digit verification code instantly.",
                                    textAlign: TextAlign.center,
                                    style: TextStyles.font14GrayRegular,
                                  ),
                                  verticalSpacing(24),
                                  CustomTextFormField(
                                    controller: authCubit.emailController,
                                    hintText: "Email",
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !AppRegex.isPhoneNumberOrEmailValid(
                                            "2$value",
                                          )) {
                                        return "Please enter a valid email or phone number";
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SendOtpBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateForgotPassword(AuthCubit authCubit) {
    if (authCubit.formKey.currentState!.validate()) {
      authCubit.sendOtp(isForgetPass: true);
    }
  }
}
