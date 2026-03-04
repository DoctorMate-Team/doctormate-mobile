import 'package:doctor_mate/core/models/device_token_request.dart';
import 'package:doctor_mate/core/networking/api_error_handler.dart';
import 'package:doctor_mate/core/networking/api_result.dart';
import 'package:doctor_mate/core/networking/device_token_api_service.dart';

class DeviceTokenRepository {
  final DeviceTokenApiService _apiService;

  DeviceTokenRepository(this._apiService);

  Future<ApiResult<void>> registerDeviceToken({
    required String token,
    required String deviceType,
    required String deviceName,
  }) async {
    try {
      final request = DeviceTokenRegisterRequest(
        token: token,
        deviceType: deviceType,
        deviceName: deviceName,
      );
      await _apiService.registerDeviceToken(request);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> unregisterDeviceToken({required String token}) async {
    try {
      final request = DeviceTokenUnregisterRequest(token: token);
      await _apiService.unregisterDeviceToken(request);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
