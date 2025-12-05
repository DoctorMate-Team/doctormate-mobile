import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/home/data/models/doctor_model.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'home_apis_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class HomeApisServices {
  factory HomeApisServices(Dio dio, {String? baseUrl}) =>
      _HomeApisServices(dio);

  @GET(ApiConstants.specialties)
  Future<DoctorMateResponse<List<SpecialtyModel>>> getSpecialties();

  @GET(ApiConstants.doctorsBySpecialty)
  Future<DoctorMateResponse<DoctorSpecialtyResponse>> getDoctorsBySpecialty(
    @Path("specialtyId") String specialtyId,
    @Query("page") int page,
    @Query("limit") int limit,
  );
}
