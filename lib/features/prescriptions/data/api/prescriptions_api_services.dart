import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/prescriptions/data/models/prescription_details_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'prescriptions_api_services.g.dart';
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class PrescriptionsApiServices {
  factory PrescriptionsApiServices(Dio dio, {String baseUrl}) =
      _PrescriptionsApiServices;

  //{{baseUrl}}prescriptions?appointment_id={{appointmentId}}
  @GET(ApiConstants.prescriptions)
  Future<DoctorMateResponse<PrescriptionDetailsResponse>> getPrescriptionDetails(
      @Query("appointment_id") String appointmentId);
} 