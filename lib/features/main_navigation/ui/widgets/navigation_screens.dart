import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_cubit.dart';
import 'package:doctor_mate/features/appointment/ui/appointment_management_screen.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_cubit.dart';
import 'package:doctor_mate/features/home/ui/home_screen.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_cubit.dart';
import 'package:doctor_mate/features/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NavigationScreens {
  static final List<Widget> screens = [
    BlocProvider(
      create: (context) => getIt<HomeCubit>()..getSpecialties(),
      child: const HomeScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<AppointmentManageCubit>(),
      child: const AppointmentManagementScreen(),
    ),
    const ExploreScreen(),
    const MessagesScreen(),
    BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: const ProfileScreen(),
    ),
  ];
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('استكشاف', style: TextStyles.font18DarkGreenBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.search_normal,
              size: 80.sp,
              color: const Color(0xFFEA4335),
            ),
            SizedBox(height: 16.h),
            Text('شاشة الاستكشاف', style: TextStyles.font18DarkGreenBold),
            SizedBox(height: 8.h),
            Text(
              'اكتشف الأطباء والخدمات الطبية',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('المحادثات', style: TextStyles.font18DarkGreenBold),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.message, size: 80.sp, color: const Color(0xFFFBBC05)),
            SizedBox(height: 16.h),
            Text('المحادثات', style: TextStyles.font18DarkGreenBold),
            SizedBox(height: 8.h),
            Text(
              'محادثاتك مع الأطباء والدعم الفني',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
