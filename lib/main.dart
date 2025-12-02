import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/core/helper/bloc_observer.dart';
import 'package:doctor_mate/core/helper/cache_helper.dart';
import 'package:doctor_mate/core/helper/constants.dart';
import 'package:doctor_mate/doctormate_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  // to fix .sp font size and text hidden
  await ScreenUtil.ensureScreenSize();

  // منع دوران الشاشة
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // الوضع الرأسي فقط
  ]);

  // Setup dependency injection
  await setupGetIt();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: AppConstants.translationPath, // Folder for translation files
      fallbackLocale: const Locale('en'),
      child: const DoctorMateApp(),
    ),
  );
}
