import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'details_apis_services.g.dart';
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class DetailsApiServices {
  factory DetailsApiServices(Dio dio, {String baseUrl}) = _DetailsApiServices;

  @GET(ApiConstants.doctorDetails)
  Future<DoctorMateResponse<DoctorDetailsModel>> getDoctorDetails({
    @Path("doctorId") required String doctorId,
  });
}