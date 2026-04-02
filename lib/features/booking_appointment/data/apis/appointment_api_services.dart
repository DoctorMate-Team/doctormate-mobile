import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_request_body.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/available_slots_response.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/initiate_payment_request.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/initiate_payment_response.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/update_payment_status_request.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'appointment_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AppointmentApiServices {
  factory AppointmentApiServices(Dio dio, {String? baseUrl}) =
      _AppointmentApiServices;

  @GET(ApiConstants.availableSlots)
  Future<DoctorMateResponse<AvailableSlotsResponse>> getAvailableSlots(
    @Path("doctorId") String doctorId,
    @Query("date") String date,
  );

  @POST(ApiConstants.appointments)
  Future<DoctorMateResponse<AppointmentResponseBody>> bookAppointment(
    @Body() AppointmentRequestBody appointmentData,
  );

  @POST(ApiConstants.initiatePayment)
  Future<DoctorMateResponse<InitiatePaymentResponse>> initiatePayment(
    @Body() InitiatePaymentRequest request,
  );

  @PUT(ApiConstants.updatePaymentStatus)
  Future<DoctorMateResponse<void>> updatePaymentStatus(
    @Path("paymentId") String paymentId,
    @Body() UpdatePaymentStatusRequest request,
  );

  @POST(ApiConstants.medicalImages)
  Future<DoctorMateResponse<void>> uploadMedicalImage(
    @Body() FormData formData,
  );
}
