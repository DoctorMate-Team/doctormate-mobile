import 'package:doctor_mate/core/helper/constants.dart';
import 'package:doctor_mate/core/routing/app_router.dart';
import 'package:doctor_mate/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class DoctorMateApp extends StatelessWidget {
  const DoctorMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.languageKey = context.locale.languageCode;
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
          title: 'HehiaServe',
          routerConfig: AppRouter.mainRouting(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
      )
    );
  }
}