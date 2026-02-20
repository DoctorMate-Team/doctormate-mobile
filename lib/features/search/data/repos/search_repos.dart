import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:doctor_mate/features/search/data/api/search_api_services.dart';

class SearchRepos {
  final SearchApiServices _searchApiServices;

  SearchRepos(this._searchApiServices);

  Future<ApiResult<DoctorMateResponse<DoctorSpecialtyResponse>>> searchDoctors({
    required String query,
    String? specialtyId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _searchApiServices.searchDoctors(
        query: query,
        specialtyId: specialtyId,
        sort: sort,
        page: page,
        limit: limit,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<List<SpecialtyModel>>>>
      getSpecialties() async {
    try {
      final response = await _searchApiServices.getSpecialties();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
