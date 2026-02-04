import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_cubit.dart';
import 'package:doctor_mate/features/appointment/ui/appointment_management_screen.dart';
import 'package:doctor_mate/features/chat/ui/chat_screen.dart';
import 'package:doctor_mate/features/home/logic/cubit/home_cubit.dart';
import 'package:doctor_mate/features/home/ui/home_screen.dart';
import 'package:doctor_mate/features/medical-record/logic/cubit/medical_records_cubit.dart';
import 'package:doctor_mate/features/medical-record/ui/medical_record_screen.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_cubit.dart';
import 'package:doctor_mate/features/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider(
      create:
          (context) =>
              getIt<MedicalRecordsCubit>()
                ..getPatientMedicalRecords(page: 1, limit: 10),
      child: const MedicalRecordScreen(),
    ),
    const ChatScreen(),
    BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfile(),
      child: const ProfileScreen(),
    ),
  ];
}
