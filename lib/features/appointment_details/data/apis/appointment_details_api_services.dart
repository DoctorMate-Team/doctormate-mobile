import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'appointment_details_api_services.g.dart';
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AppointmentDetailsApiServices {
  factory AppointmentDetailsApiServices(Dio dio, {String baseUrl}) =
      _AppointmentDetailsApiServices;

  @GET(ApiConstants.appointmentDetails)
  Future<DoctorMateResponse<AppointmentDetailsResponse>> getAppointmentDetails({
    @Path("appointmentId") required String appointmentId,
  });
}