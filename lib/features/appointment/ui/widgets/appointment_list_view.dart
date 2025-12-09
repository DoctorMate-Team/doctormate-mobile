import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_cubit.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_state.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/appointment_card.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/appointment_empty_state.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/appointment_error_state.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/appointment_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentListView extends StatelessWidget {
  final String status;
  final List<PatientAppointmentModel> appointments;
  final VoidCallback onRefresh;
  final Function(PatientAppointmentModel) onCancel;
  final Function(PatientAppointmentModel) onReschedule;

  const AppointmentListView({
    super.key,
    required this.status,
    required this.appointments,
    required this.onRefresh,
    required this.onCancel,
    required this.onReschedule,
  });

  List<PatientAppointmentModel> _filterAppointmentsByStatus() {
    switch (status) {
      case 'upcoming':
        return appointments
            .where(
              (apt) =>
                  apt.status.toLowerCase() == 'scheduled' ||
                  apt.status.toLowerCase() == 'upcoming',
            )
            .toList();
      case 'completed':
        return appointments
            .where((apt) => apt.status.toLowerCase() == 'completed')
            .toList();
      case 'cancelled':
        return appointments
            .where((apt) => apt.status.toLowerCase() == 'cancelled')
            .toList();
      default:
        return appointments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentManageCubit, AppointmentManageState>(
      buildWhen: (previous, current) => current is LoadedAppointmentsPatient ||
          current is ErrorAppointmentsPatient ||
          current is LoadingAppointmentsPatient,
      builder: (context, state) {
        return state.maybeWhen(
          loadingAppointmentsPatient: () => const AppointmentShimmerLoading(),
          loadedAppointmentsPatient: (_) {
            final filteredAppointments = _filterAppointmentsByStatus();

            if (filteredAppointments.isEmpty) {
              return AppointmentEmptyState(status: status);
            }

            return RefreshIndicator(
              onRefresh: () async {
                onRefresh();
              },
              color: ColorsManager.primaryColor,
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: filteredAppointments.length,
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    appointment: filteredAppointments[index],
                    status: status,
                    onCancel: () => onCancel(filteredAppointments[index]),
                    onReschedule:
                        () => onReschedule(filteredAppointments[index]),
                  );
                },
              ),
            );
          },
          errorAppointmentsPatient:
              (message) =>
                  AppointmentErrorState(message: message, onRetry: onRefresh),
          orElse: () => const AppointmentShimmerLoading(),
        );
      },
    );
  }
}
