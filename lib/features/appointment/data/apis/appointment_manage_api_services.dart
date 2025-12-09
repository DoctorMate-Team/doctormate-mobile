import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'appointment_manage_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AppointmentManageApiServices {
  factory AppointmentManageApiServices(Dio dio, {String baseUrl}) =
      _AppointmentManageApiServices;

  @GET(ApiConstants.patientAppointments)
  Future<DoctorMateResponse<AppointmentListResponse>> getPatientAppointments({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  @PUT(ApiConstants.updateAppointmentStatus)
  Future<DoctorMateResponse<void>> updateAppointmentStatus({
    @Path('appointmentId') required String appointmentId,
    @Body() required Map<String, String> statusUpdate,
  });
}
