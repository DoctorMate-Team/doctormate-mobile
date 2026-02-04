import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/smart-checkup/data/api/smart_checkup_api_services.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/smart_check_response.dart';

class SmartCheckupRepos {
  final SmartCheckupApiServices _apiServices;

  SmartCheckupRepos(this._apiServices);

  Future<ApiResult<DoctorMateResponse<SmartCheckResponse>>> performSkinCheckup(String imagePath) async {
    try {
      final response = await _apiServices.performSkinCheckup(
        FormData.fromMap({
          "file": await MultipartFile.fromFile(imagePath),
        }),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<SmartCheckResponse>>> performSymptomCheckup({required String symptoms}) async {
    try {
      final response = await _apiServices.performSymptomCheckup({"symptoms": symptoms});
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}