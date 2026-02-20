import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/chat/data/models/communication_call_response.dart';
import 'package:doctor_mate/features/chat/data/models/communication_session_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'chat_api_services.g.dart';
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ChatApiServices {
  factory ChatApiServices(Dio dio, {String baseUrl}) = _ChatApiServices;

  @POST(ApiConstants.communicationSessions)
  Future<DoctorMateResponse<CommunicationSessionResponse>> createCommunicationSession({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiConstants.communicationCallToken)
  Future<DoctorMateResponse<CommunicationCallResponse>> getCallToken({
    @Body() required Map<String, dynamic> body,
  });

  @POST(ApiConstants.communicationCloseSession)
  Future<DoctorMateResponse<void>> closeCommunicationSession({
    @Path("sessionId") required String sessionId,
  });

  @GET(ApiConstants.communicationSessionByAppointment)
  Future<DoctorMateResponse<CommunicationSessionResponse>> getCommunicationSessionByAppointment({
    @Path("appointmentId") required String appointmentId,
  });
}