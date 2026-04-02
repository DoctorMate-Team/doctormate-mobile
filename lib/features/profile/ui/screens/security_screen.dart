import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/features/profile/logic/cubit/security_cubit.dart';
import 'package:doctor_mate/features/profile/logic/cubit/security_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onChangePassword() {
    if (_formKey.currentState!.validate()) {
      context.read<SecurityCubit>().changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: ColorsManager.primaryColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text('Security', style: TextStyles.font18DarkGreenBold),
      ),
      body: BlocListener<SecurityCubit, SecurityState>(
        listener: (context, state) {
          state.maybeWhen(
            changePasswordSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password changed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              context.pop();
            },
            changePasswordError: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<SecurityCubit, SecurityState>(
          builder: (context, state) {
            final isLoading = state is ChangePasswordLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Change Password',
                        style: TextStyles.font16DarkGreenBold,
                      ),
                      verticalSpacing(8),
                      Text(
                        'Your password must be at least 8 characters long',
                        style: TextStyles.font14GrayRegular,
                      ),
                      verticalSpacing(32),

                      // Current Password Field
                      CustomTextFormField(
                        controller: _currentPasswordController,
                        hintText: 'Current Password',
                        readOnly: _obscureCurrentPassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const Icon(
                            Iconsax.lock,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureCurrentPassword
                                ? Iconsax.eye_slash
                                : Iconsax.eye,
                            color: ColorsManager.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureCurrentPassword =
                                  !_obscureCurrentPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your current password';
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(20),

                      // New Password Field
                      CustomTextFormField(
                        controller: _newPasswordController,
                        hintText: 'New Password',
                        readOnly: _obscureNewPassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const Icon(
                            Iconsax.lock,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNewPassword
                                ? Iconsax.eye_slash
                                : Iconsax.eye,
                            color: ColorsManager.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(20),

                      // Confirm Password Field
                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm New Password',
                        readOnly: _obscureConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const Icon(
                            Iconsax.lock,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Iconsax.eye_slash
                                : Iconsax.eye,
                            color: ColorsManager.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(40),

                      // Save Button
                      CustomMaterialButton(
                        textButton:
                            isLoading ? 'Changing...' : 'Change Password',
                        onPressed: isLoading ? () {} : _onChangePassword,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
