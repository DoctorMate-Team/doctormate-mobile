import 'package:dio/dio.dart';
import 'package:doctor_mate/core/models/doctor_mate_response.dart';
import 'package:doctor_mate/core/networking/api_constants.dart';
import 'package:doctor_mate/features/profile/data/models/profile_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'profile_api_services.g.dart';
@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ProfileApiServices {
  factory ProfileApiServices(Dio dio, {String baseUrl}) = _ProfileApiServices;

  // Get Profile Details
  @GET(ApiConstants.profileManagement)
  Future<DoctorMateResponse<ProfileResponseModel>> getProfile();

  //Update Profile Image
  @POST(ApiConstants.uploadProfileImage)
  Future<DoctorMateResponse<void>> uploadProfileImage(
     @Body() FormData formData,
  );

  //Update Profile Details
  @PUT(ApiConstants.updateProfileDetails)
  Future<DoctorMateResponse<void>> updateProfileDetails();
}