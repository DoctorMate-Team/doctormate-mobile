import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/home/data/apis/home_apis_services.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';

class HomeRepos {
  final HomeApisServices _homeApiServices;

  HomeRepos(this._homeApiServices);

  Future<ApiResult<DoctorMateResponse<List<SpecialtyModel>>>>
  getSpecialties() async {
    try {
      final response = await _homeApiServices.getSpecialties();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<DoctorSpecialtyResponse>>>
  getDoctorsBySpecialty({required String specialtyId, required int page, required int limit}) async {
    try {
      final response = await _homeApiServices.getDoctorsBySpecialty(
        specialtyId,
        page,
        limit,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
