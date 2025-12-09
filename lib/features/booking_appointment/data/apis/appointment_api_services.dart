import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_request_body.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/available_slots_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'appointment_api_services.g.dart';
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AppointmentApiServices {
  factory AppointmentApiServices(Dio dio, {String? baseUrl}) =
      _AppointmentApiServices;
  //{{baseUrl}}doctors/{{doctor_id}}/available-slots?date=2025-12-24
  @GET(ApiConstants.availableSlots)
  Future<DoctorMateResponse<AvailableSlotsResponse>> getAvailableSlots(
    @Path("doctorId") String doctorId,
    @Query("date") String date,
  );

  @POST(ApiConstants.appointments)
  Future<DoctorMateResponse<AppointmentResponseBody>> bookAppointment(
    @Body() AppointmentRequestBody appointmentData,
  );
}