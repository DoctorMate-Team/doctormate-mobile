import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/features/booking_appointment/data/apis/appointment_api_services.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_request_body.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/available_slots_response.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/initiate_payment_request.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/initiate_payment_response.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/update_payment_status_request.dart';

class AppointmentRepos {
  final AppointmentApiServices _appointmentApiServices;

  AppointmentRepos(this._appointmentApiServices);

  Future<ApiResult<DoctorMateResponse<AvailableSlotsResponse>>>
  getAvailableSlots({required String doctorId, required String date}) async {
    try {
      final response = await _appointmentApiServices.getAvailableSlots(
        doctorId,
        date,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<AppointmentResponseBody>>>
  bookAppointment({required AppointmentRequestBody appointmentData}) async {
    try {
      final response = await _appointmentApiServices.bookAppointment(
        appointmentData,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<InitiatePaymentResponse>>>
  initiatePayment({required InitiatePaymentRequest request}) async {
    try {
      final response = await _appointmentApiServices.initiatePayment(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> updatePaymentStatus({
    required String paymentId,
    required UpdatePaymentStatusRequest request,
  }) async {
    try {
      final response = await _appointmentApiServices.updatePaymentStatus(
        paymentId,
        request,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DoctorMateResponse<void>>> uploadMedicalImage({
    required String appointmentId,
    required String description,
    required String filePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'AppointmentId': appointmentId,
        'Description': description,
        'File': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });
      final response = await _appointmentApiServices.uploadMedicalImage(
        formData,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
