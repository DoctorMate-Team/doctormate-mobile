import 'package:dio/dio.dart';
import 'package:doctor_mate/core/networking/dio_factory.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
}
