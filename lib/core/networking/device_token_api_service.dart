import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/device_token_request.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'device_token_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class DeviceTokenApiService {
  factory DeviceTokenApiService(Dio dio, {String baseUrl}) =
      _DeviceTokenApiService;

  @POST(ApiConstants.deviceTokenRegister)
  Future<void> registerDeviceToken(@Body() DeviceTokenRegisterRequest request);

  @DELETE(ApiConstants.deviceTokenUnregister)
  Future<void> unregisterDeviceToken(
    @Body() DeviceTokenUnregisterRequest request,
  );
}
