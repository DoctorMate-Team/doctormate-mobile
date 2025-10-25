import 'package:dio/dio.dart';
import 'package:doctor_mate/core/networking/dio_factory.dart';
import 'package:doctor_mate/features/auth/data/apis/auth_api_services.dart';
import 'package:doctor_mate/features/auth/data/repos/auth_repos.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  // Auth
  getIt.registerLazySingleton<AuthApiServices>(() => AuthApiServices(dio));
  getIt.registerLazySingleton<AuthRepos>(() => AuthRepos(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
}
