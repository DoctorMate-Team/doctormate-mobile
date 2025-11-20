import 'package:dio/dio.dart';
import 'package:doctor_mate/core/networking/dio_factory.dart';
import 'package:doctor_mate/features/auth/data/apis/auth_api_services.dart';
import 'package:doctor_mate/features/auth/data/repos/auth_repos.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/details/data/apis/details_apis_services.dart';
import 'package:doctor_mate/features/details/data/repos/details_repos.dart';
import 'package:doctor_mate/features/details/logic/cubit/details_cubit.dart';
import 'package:doctor_mate/features/home/data/apis/home_apis_services.dart';
import 'package:doctor_mate/features/home/data/repos/home_repos.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_cubit.dart';
import 'package:doctor_mate/features/main_navigation/logic/cubit/main_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();

  // Auth
  getIt.registerLazySingleton<AuthApiServices>(() => AuthApiServices(dio));
  getIt.registerLazySingleton<AuthRepos>(() => AuthRepos(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  // Home
  getIt.registerLazySingleton<HomeApisServices>(() => HomeApisServices(dio));
  getIt.registerLazySingleton<HomeRepos>(() => HomeRepos(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  // Main Navigation
  getIt.registerFactory<MainCubit>(() => MainCubit());

  // Details
  getIt.registerLazySingleton<DetailsApiServices>(
    () => DetailsApiServices(dio),
  );
  getIt.registerLazySingleton<DetailsRepos>(() => DetailsRepos(getIt()));
  getIt.registerFactory<DetailsCubit>(() => DetailsCubit(getIt()));
}
