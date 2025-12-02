import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/profile/data/apis/profile_api_services.dart';
import 'package:doctor_mate/features/profile/data/models/profile_response_model.dart';

class ProfileRepos {
final ProfileApiServices _profileApiServices;

  ProfileRepos(this._profileApiServices);

  Future<ApiResult<DoctorMateResponse<ProfileResponseModel>>> getProfile() async{
    try {
      final response = await _profileApiServices.getProfile();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> uploadProfileImage({required String imagePath}) async{
    try {
      final response = await _profileApiServices.uploadProfileImage(
          FormData.fromMap({
            "image": await MultipartFile.fromFile(imagePath),
          }),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> updateProfileDetails() async{
    try {
      final response = await _profileApiServices.updateProfileDetails();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}