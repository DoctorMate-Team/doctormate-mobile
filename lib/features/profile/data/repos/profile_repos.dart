import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/profile/data/apis/profile_api_services.dart';
import 'package:doctor_mate/features/profile/data/models/profile_response_model.dart';
import 'package:doctor_mate/features/profile/data/models/payment_history_model.dart';

class ProfileRepos {
  final ProfileApiServices _profileApiServices;

  ProfileRepos(this._profileApiServices);

  Future<ApiResult<DoctorMateResponse<ProfileResponseModel>>>
  getProfile() async {
    try {
      final response = await _profileApiServices.getProfile();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> uploadProfileImage({
    required String imagePath,
  }) async {
    try {
      final response = await _profileApiServices.uploadProfileImage(
        FormData.fromMap({"image": await MultipartFile.fromFile(imagePath)}),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> updateProfileDetails({
    required String fullName,
    required String phoneNumber,
    required String address,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'address': address,
        if (imagePath != null && imagePath.isNotEmpty)
          'imageFile': await MultipartFile.fromFile(imagePath),
      });
      final response = await _profileApiServices.updateProfileDetails(formData);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<PaymentHistoryResponse>>> getMyPayments({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _profileApiServices.getMyPayments(page, limit);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
