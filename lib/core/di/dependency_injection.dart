import 'package:dio/dio.dart';
import 'package:doctor_mate/features/profile/logic/payment_history_cubit/payment_history_cubit.dart';
import 'package:doctor_mate/core/networking/device_token_api_service.dart';
import 'package:doctor_mate/core/networking/device_token_repository.dart';
import 'package:doctor_mate/core/networking/dio_factory.dart';
import 'package:doctor_mate/features/appointment/data/apis/appointment_manage_api_services.dart';
import 'package:doctor_mate/features/appointment/data/repos/appointment_manage_repos.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_cubit.dart';
import 'package:doctor_mate/features/booking_appointment/data/apis/appointment_api_services.dart';
import 'package:doctor_mate/features/booking_appointment/data/repos/appointment_repos.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_cubit.dart';
import 'package:doctor_mate/features/auth/data/apis/auth_api_services.dart';
import 'package:doctor_mate/features/auth/data/repos/auth_repos.dart';
import 'package:doctor_mate/features/auth/logic/cubit/auth_cubit.dart';
import 'package:doctor_mate/features/appointment_details/data/apis/appointment_details_api_services.dart';
import 'package:doctor_mate/features/appointment_details/data/repos/appointment_details_repos.dart';
import 'package:doctor_mate/features/appointment_details/logic/cubit/appointment_details_cubit.dart';
import 'package:doctor_mate/features/chat/data/apis/chat_api_services.dart';
import 'package:doctor_mate/features/chat/data/services/firestore_chat_service.dart';
import 'package:doctor_mate/features/chat/logic/chat_list_cubit.dart';
import 'package:doctor_mate/features/chat/logic/communication_cubit.dart';
import 'package:doctor_mate/features/details/data/apis/details_apis_services.dart';
import 'package:doctor_mate/features/details/data/repos/details_repos.dart';
import 'package:doctor_mate/features/details/logic/cubit/details_cubit.dart';
import 'package:doctor_mate/features/home/data/apis/home_apis_services.dart';
import 'package:doctor_mate/features/home/data/repos/home_repos.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_cubit.dart';
import 'package:doctor_mate/features/main_navigation/logic/cubit/main_cubit.dart';
import 'package:doctor_mate/features/medical-record/data/api/medical_records_api_services.dart';
import 'package:doctor_mate/features/medical-record/data/repos/medical_records_repos.dart';
import 'package:doctor_mate/features/medical-record/logic/cubit/medical_records_cubit.dart';
import 'package:doctor_mate/features/prescriptions/data/api/prescriptions_api_services.dart';
import 'package:doctor_mate/features/prescriptions/data/repos/prescriptions_repos.dart';
import 'package:doctor_mate/features/prescriptions/logic/cubit/prescriptions_cubit.dart';
import 'package:doctor_mate/features/profile/data/apis/profile_api_services.dart';
import 'package:doctor_mate/features/profile/data/repos/profile_repos.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_cubit.dart';
import 'package:doctor_mate/features/search/data/api/search_api_services.dart';
import 'package:doctor_mate/features/search/data/repos/search_repos.dart';
import 'package:doctor_mate/features/search/logic/cubit/search_cubit.dart';
import 'package:doctor_mate/features/notifications/data/apis/notifications_api_service.dart';
import 'package:doctor_mate/features/notifications/data/repos/notifications_repository.dart';
import 'package:doctor_mate/features/notifications/logic/notifications_cubit.dart';
import 'package:doctor_mate/features/reviews/data/apis/reviews_api_service.dart';
import 'package:doctor_mate/features/reviews/data/repos/reviews_repository.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_cubit.dart';
import 'package:doctor_mate/features/smart-checkup/data/api/smart_checkup_api_services.dart';
import 'package:doctor_mate/features/smart-checkup/data/repos/smart_checkup_repos.dart';
import 'package:doctor_mate/features/smart-checkup/logic/cubit/smart_checkup_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = await DioFactory.getDio();

  // Device Token
  getIt.registerLazySingleton<DeviceTokenApiService>(
    () => DeviceTokenApiService(dio),
  );
  getIt.registerLazySingleton<DeviceTokenRepository>(
    () => DeviceTokenRepository(getIt()),
  );

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

  // Profile
  getIt.registerLazySingleton<ProfileApiServices>(
    () => ProfileApiServices(dio),
  );
  getIt.registerLazySingleton<ProfileRepos>(() => ProfileRepos(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
  getIt.registerFactory<PaymentHistoryCubit>(
    () => PaymentHistoryCubit(getIt()),
  );

  // Appointment
  getIt.registerLazySingleton<AppointmentApiServices>(
    () => AppointmentApiServices(dio),
  );
  getIt.registerLazySingleton<AppointmentRepos>(
    () => AppointmentRepos(getIt()),
  );
  getIt.registerFactory<AppointmentCubit>(() => AppointmentCubit(getIt()));

  // Appointment Management
  getIt.registerLazySingleton<AppointmentManageApiServices>(
    () => AppointmentManageApiServices(dio),
  );
  getIt.registerLazySingleton<AppointmentManageRepos>(
    () => AppointmentManageRepos(getIt()),
  );
  getIt.registerFactory<AppointmentManageCubit>(
    () => AppointmentManageCubit(getIt()),
  );

  // Medical Records
  getIt.registerLazySingleton<MedicalRecordsApiServices>(
    () => MedicalRecordsApiServices(dio),
  );
  getIt.registerLazySingleton<MedicalRecordsRepos>(
    () => MedicalRecordsRepos(getIt()),
  );
  getIt.registerFactory<MedicalRecordsCubit>(
    () => MedicalRecordsCubit(getIt()),
  );

  // Prescriptions
  getIt.registerLazySingleton<PrescriptionsApiServices>(
    () => PrescriptionsApiServices(dio),
  );
  getIt.registerLazySingleton<PrescriptionsRepos>(
    () => PrescriptionsRepos(getIt()),
  );
  getIt.registerFactory<PrescriptionsCubit>(() => PrescriptionsCubit(getIt()));

  // Smart Checkup
  getIt.registerLazySingleton<SmartCheckupApiServices>(
    () => SmartCheckupApiServices(dio),
  );
  getIt.registerLazySingleton<SmartCheckupRepos>(
    () => SmartCheckupRepos(getIt()),
  );
  getIt.registerFactory<SmartCheckupCubit>(() => SmartCheckupCubit(getIt()));

  // Chat & Communication
  getIt.registerLazySingleton<ChatApiServices>(() => ChatApiServices(dio));
  getIt.registerLazySingleton<FirestoreChatService>(
    () => FirestoreChatService(),
  );
  getIt.registerFactory<CommunicationCubit>(
    () => CommunicationCubit(getIt<ChatApiServices>()),
  );
  getIt.registerFactory<ChatListCubit>(
    () => ChatListCubit(
      getIt<AppointmentManageApiServices>(),
      getIt<ChatApiServices>(),
      getIt<FirestoreChatService>(),
      getIt<ProfileRepos>(),
    ),
  );

  // Appointment Details
  getIt.registerLazySingleton<AppointmentDetailsApiServices>(
    () => AppointmentDetailsApiServices(dio),
  );
  getIt.registerLazySingleton<AppointmentDetailsRepos>(
    () => AppointmentDetailsRepos(getIt()),
  );
  getIt.registerFactory<AppointmentDetailsCubit>(
    () => AppointmentDetailsCubit(getIt()),
  );

  // Search
  getIt.registerLazySingleton<SearchApiServices>(() => SearchApiServices(dio));
  getIt.registerLazySingleton<SearchRepos>(() => SearchRepos(getIt()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt()));

  // Notifications
  getIt.registerLazySingleton<NotificationsApiService>(
    () => NotificationsApiService(dio),
  );
  getIt.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepository(getIt()),
  );
  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt()));

  // Reviews
  getIt.registerLazySingleton<ReviewsApiService>(() => ReviewsApiService(dio));
  getIt.registerLazySingleton<ReviewsRepository>(
    () => ReviewsRepository(getIt()),
  );
  getIt.registerFactory<ReviewsCubit>(() => ReviewsCubit(getIt()));
}
