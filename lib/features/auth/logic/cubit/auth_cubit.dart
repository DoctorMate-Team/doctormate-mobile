import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_mate/core/functions/custom_image_picker_and_compress.dart';
import 'package:doctor_mate/core/helper/constants.dart';
import 'package:doctor_mate/features/auth/data/models/complete_profile_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/send_otp_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/login_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/register_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/reset_password_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/verify_otp_request_body.dart';
import 'package:doctor_mate/features/auth/data/repos/auth_repos.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepos) : super(AuthState.initial());
  final AuthRepos _authRepos;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  File? profileImage;

  void login() async {
    emit(AuthState.loginLoading());
    final result = await _authRepos.login(
      loginRequestBody: LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    result.when(
      success: (auth) {
        AppConstants.userTokenProvider = auth.data.token;
        emit(AuthState.loginSuccess(auth.data));
      },
      failure: (error) {
        emit(AuthState.loginError(message: error.apiErrorModel.message!));
      },
    );
  }

  void register() async {
    emit(AuthState.registerLoading());
    final result = await _authRepos.register(
      registerRequestBody: RegisterRequestBody(
        email: emailController.text,
        password: passwordController.text,
        phoneNumber: phoneNumberController.text,
        role: 'Patient',
        fullName: nameController.text,
      ),
    );
    result.when(
      success: (auth) {
        emit(AuthState.registerSuccess(auth.data));
      },
      failure: (error) {
        emit(AuthState.registerError(message: error.apiErrorModel.message!));
      },
    );
  }

  void completeProfile() async {
    emit(AuthState.completeProfileLoading());

    // First, upload profile image if selected
    if (profileImage != null) {
      try {
        final multipartFile = await MultipartFile.fromFile(
          profileImage!.path,
          filename: profileImage!.path.split('/').last,
        );

        final uploadResult = await _authRepos.uploadProfileImage(
          image: multipartFile,
        );

        // Check if upload failed
        final uploadSuccess = await uploadResult.when(
          success: (_) => true,
          failure: (_) => false,
        );

        if (!uploadSuccess) {
          emit(
            const AuthState.completeProfileError(
              message: 'Failed to upload profile image',
            ),
          );
          return;
        }
      } catch (e) {
        emit(
          AuthState.completeProfileError(
            message: 'Error uploading image: ${e.toString()}',
          ),
        );
        return;
      }
    }

    // Then complete the profile with form data
    final result = await _authRepos.completeProfile(
      completeProfileRequestBody: CompleteProfileRequestBody(
        birthDate: _formatDateForApi(dateOfBirthController.text),
        gender: genderController.text,
        address: addressController.text,
        bloodType: bloodTypeController.text,
      ),
    );
    result.when(
      success: (auth) {
        emit(AuthState.completeProfileSuccess());
      },
      failure: (error) {
        emit(
          AuthState.completeProfileError(message: error.apiErrorModel.message!),
        );
      },
    );
  }

  void sendOtp({required bool isForgetPass}) async {
    emit(AuthState.sendOtpLoading());
    final result = await _authRepos.sendOtp(
      sendOtpRequestBody: SendOtpRequestBody(
        email: emailController.text,
        isForgetPass: isForgetPass,
      ),
    );
    result.when(
      success: (auth) {
        emit(AuthState.sendOtpSuccess());
      },
      failure: (error) {
        emit(AuthState.sendOtpError(message: error.apiErrorModel.message!));
      },
    );
  }

  void resetPassword({required String email}) async {
    emit(AuthState.resetPasswordLoading());
    final result = await _authRepos.resetPassword(
      resetPasswordRequestBody: ResetPasswordRequestBody(
        email: email,
        newPassword: passwordController.text,
        confirmPassword: passwordConfirmationController.text,
      ),
    );
    result.when(
      success: (auth) {
        emit(AuthState.resetPasswordSuccess());
      },
      failure: (error) {
        emit(
          AuthState.resetPasswordError(message: error.apiErrorModel.message!),
        );
      },
    );
  }

  void verifyOtp({required bool isForgetPass}) async {
    emit(AuthState.verifyOtpLoading());
    final result = await _authRepos.verifyOtp(
      verifyOtpRequestBody: VerifyOtpRequestBody(
        email: emailController.text,
        otpCode: otpController.text,
        isForgetPass: isForgetPass,
      ),
    );
    result.when(
      success: (auth) {
        emit(AuthState.verifyOtpSuccess());
      },
      failure: (error) {
        emit(AuthState.verifyOtpError(message: error.apiErrorModel.message!));
      },
    );
  }

  String _formatDateForApi(String dateString) {
    if (dateString.isEmpty) return '';

    try {
      // Parse DD/MM/YYYY format
      List<String> parts = dateString.split('/');
      if (parts.length == 3) {
        String day = parts[0].padLeft(2, '0');
        String month = parts[1].padLeft(2, '0');
        String year = parts[2];
        // Return in YYYY-MM-DD format
        return '$year-$month-$day';
      }
      return dateString;
    } catch (e) {
      return dateString;
    }
  }

  void pickProfileImage() async {
    try {
      final pickedImage = await pickImageAndCompress();
      if (pickedImage != null) {
        profileImage = pickedImage;
        // Emit a state to trigger UI update
        emit(AuthState.initial());
      }
    } catch (e) {
      debugPrint('Error picking profile image: $e');
    }
  }

  void uploadProfileImage() async {
    if (profileImage == null) {
      emit(
        const AuthState.uploadProfileImageError(
          message: 'Please select an image first',
        ),
      );
      return;
    }

    emit(AuthState.uploadProfileImageLoading());

    try {
      // Create MultipartFile from the image
      final multipartFile = await MultipartFile.fromFile(
        profileImage!.path,
        filename: profileImage!.path.split('/').last,
      );

      final result = await _authRepos.uploadProfileImage(image: multipartFile);

      result.when(
        success: (response) {
          emit(AuthState.uploadProfileImageSuccess());
        },
        failure: (error) {
          emit(
            AuthState.uploadProfileImageError(
              message: error.apiErrorModel.message ?? 'Failed to upload image',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        AuthState.uploadProfileImageError(
          message: 'Error uploading image: ${e.toString()}',
        ),
      );
    }
  }

  void clearProfileImage() {
    profileImage = null;
    emit(AuthState.initial());
  }
}
