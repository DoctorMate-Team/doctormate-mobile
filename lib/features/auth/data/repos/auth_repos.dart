import 'package:dio/dio.dart';
import 'package:doctor_mate/core/helper/constants.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/auth/data/apis/auth_api_services.dart';
import 'package:doctor_mate/features/auth/data/models/complete_profile_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/send_otp_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/login_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/login_response_model.dart';
import 'package:doctor_mate/features/auth/data/models/register_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/register_response_model.dart';
import 'package:doctor_mate/features/auth/data/models/reset_password_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/verify_otp_request_body.dart';

class AuthRepos {
  final AuthApiServices _authApiServices;

  AuthRepos(this._authApiServices);

  Future<ApiResult<DoctorMateResponse<LoginResponseModel>>> login({
    required LoginRequestBody loginRequestBody,
  }) async {
    try {
      final response = await _authApiServices.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<RegisterResponseModel>>> register({
    required RegisterRequestBody registerRequestBody,
  }) async {
    try {
      final response = await _authApiServices.register(registerRequestBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> completeProfile({
    required CompleteProfileRequestBody completeProfileRequestBody,
  }) async {
    try {
      final response = await _authApiServices.completeProfile(
        completeProfileRequestBody,
        'Bearer ${AppConstants.userTokenProvider}',
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> sendOtp({
    required SendOtpRequestBody sendOtpRequestBody,
  }) async {
    try {
      final response = await _authApiServices.sendOtp(sendOtpRequestBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> resetPassword({
    required ResetPasswordRequestBody resetPasswordRequestBody,
  }) async {
    try {
      final response = await _authApiServices.resetPassword(
        resetPasswordRequestBody,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> verifyOtp({
    required VerifyOtpRequestBody verifyOtpRequestBody,
  }) async {
    try {
      final response = await _authApiServices.verifyOtp(verifyOtpRequestBody);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> uploadProfileImage({
    required MultipartFile image,
  }) async {
    try {
      final formData = FormData.fromMap({'image': image});

      final response = await _authApiServices.uploadProfileImage(
        formData,
        'Bearer ${AppConstants.userTokenProvider}',
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
