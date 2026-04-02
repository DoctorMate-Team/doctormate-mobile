import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'search_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class SearchApiServices {
  factory SearchApiServices(Dio dio, {String baseUrl}) = _SearchApiServices;

  @GET(ApiConstants.searchDoctors)
  Future<DoctorMateResponse<DoctorSpecialtyResponse>> searchDoctors({
    @Query("query") required String query,
    @Query("specialtyId") String? specialtyId,
    @Query("sort") String? sort, // "rating"
    @Query("page") int page = 1,
    @Query("limit") int limit = 10,
  });

  //Get Specialties
  @GET(ApiConstants.specialties)
  Future<DoctorMateResponse<List<SpecialtyModel>>> getSpecialties();
}