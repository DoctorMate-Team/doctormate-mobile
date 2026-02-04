import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/smart_check_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'smart_checkup_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.aiBaseUrl)
abstract class SmartCheckupApiServices {
  factory SmartCheckupApiServices(Dio dio, {String baseUrl}) =
      _SmartCheckupApiServices;

  @POST(ApiConstants.aiSkinCheck)
  Future<DoctorMateResponse<SmartCheckResponse>> performSkinCheckup(
    @Body() FormData formData,
  );

  @POST(ApiConstants.aiSymptomsCheck)
  Future<DoctorMateResponse<SmartCheckResponse>> performSymptomCheckup(
    @Body() Map<String, dynamic> requestData,
  );
}
