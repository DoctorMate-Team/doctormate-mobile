import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/auth/data/models/complete_profile_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/send_otp_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/login_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/login_response_model.dart';
import 'package:doctor_mate/features/auth/data/models/register_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/register_response_model.dart';
import 'package:doctor_mate/features/auth/data/models/reset_password_request_body.dart';
import 'package:doctor_mate/features/auth/data/models/verify_otp_request_body.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AuthApiServices {
  factory AuthApiServices(Dio dio, {String? baseUrl}) => _AuthApiServices(dio);

  @POST(ApiConstants.login)
  Future<DoctorMateResponse<LoginResponseModel>> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.register)
  Future<DoctorMateResponse<RegisterResponseModel>> register(
    @Body() RegisterRequestBody registerRequestBody,
  );

  @POST(ApiConstants.completeProfile)
  Future<DoctorMateResponse<void>> completeProfile(
    @Body() CompleteProfileRequestBody completeProfileRequestBody,
    @Header("Authorization") String token,
  );

  @POST(ApiConstants.sendOtp)
  Future<DoctorMateResponse<void>> sendOtp(
    @Body() SendOtpRequestBody sendOtpRequestBody,
  );

  @POST(ApiConstants.resetPassword)
  Future<DoctorMateResponse<void>> resetPassword(
    @Body() ResetPasswordRequestBody resetPasswordRequestBody,
  );

  @POST(ApiConstants.verifyOtp)
  Future<DoctorMateResponse<void>> verifyOtp(
    @Body() VerifyOtpRequestBody verifyOtpRequestBody,
  );

  @POST(ApiConstants.uploadProfileImage)
  Future<DoctorMateResponse<void>> uploadProfileImage(
    @Body() FormData formData,
    @Header("Authorization") String token,
  );
}
