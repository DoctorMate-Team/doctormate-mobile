import 'package:doctor_mate/core/functions/custom_show_dialog.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_cubit.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_state.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/appointment_list_view.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/appointment_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppointmentManagementScreen extends StatefulWidget {
  const AppointmentManagementScreen({super.key});

  @override
  State<AppointmentManagementScreen> createState() =>
      _AppointmentManagementScreenState();
}

class _AppointmentManagementScreenState
    extends State<AppointmentManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedStatusFilter;
  final int _currentPage = 1;
  final int _pageLimit = 10;
  List<PatientAppointmentModel> _allAppointments = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _fetchAppointments({String? status}) {
    context.read<AppointmentManageCubit>().getPatientAppointments(
      page: _currentPage,
      limit: _pageLimit,
      status: status ?? _selectedStatusFilter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentManageCubit, AppointmentManageState>(
      listenWhen:
          (previous, current) =>
              current is LoadedAppointmentsPatient ||
              current is ErrorAppointmentsPatient ||
              current is UpdatedAppointmentStatus ||
              current is ErrorUpdatingAppointmentStatus,
      listener: (context, state) {
        state.maybeWhen(
          loadedAppointmentsPatient: (response) {
            setState(() {
              _allAppointments = response.appointments;
            });
          },
          errorAppointmentsPatient: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
          updatedAppointmentStatus: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment cancelled successfully'),
                backgroundColor: Colors.green,
              ),
            );
            context.pop();
            _fetchAppointments();
          },
          errorUpdatingAppointmentStatus: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
            context.pop();
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('My Appointments', style: TextStyles.font18DarkGreenBold),
          centerTitle: true,
        ),
        body: Column(
          children: [
            AppointmentTabBar(tabController: _tabController),
            // FilterChipsBar(
            //   selectedFilter: _selectedStatusFilter,
            //   onFilterChanged: (status) {
            //     setState(() {
            //       _selectedStatusFilter = status;
            //     });
            //     _fetchAppointments(status: status);
            //   },
            // ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AppointmentListView(
                    status: 'upcoming',
                    appointments: _allAppointments,
                    onRefresh: _fetchAppointments,
                    onCancel: _showCancelDialog,
                    onReschedule: _showRescheduleDialog,
                  ),
                  AppointmentListView(
                    status: 'completed',
                    appointments: _allAppointments,
                    onRefresh: _fetchAppointments,
                    onCancel: _showCancelDialog,
                    onReschedule: _showRescheduleDialog,
                  ),
                  AppointmentListView(
                    status: 'cancelled',
                    appointments: _allAppointments,
                    onRefresh: _fetchAppointments,
                    onCancel: _showCancelDialog,
                    onReschedule: _showRescheduleDialog,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(PatientAppointmentModel appointment) {
    showCustomDialog(
      context,
      title: 'Cancel Appointment?',
      subtitle:
          'Are you sure you want to cancel your appointment with ${appointment.doctor.doctorName}?',
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            'No, Keep it',
            style: TextStyles.font14GrayRegular.copyWith(
              color: ColorsManager.gray,
            ),
          ),
        ),
        CustomMaterialButton(
          textButton: 'Yes, Cancel',
          onPressed: () {
            context.read<AppointmentManageCubit>().updateAppointmentStatus(
              appointmentId: appointment.id,
            );
          },
          backgroundColor: Colors.red,
          height: 40.h,
          minWidth: 120.w,
          raduisBorder: 8,
        ),
      ],
    );
  }

  void _showRescheduleDialog(PatientAppointmentModel appointment) {
    showCustomDialog(
      context,
      title: 'Reschedule Appointment?',
      subtitle:
          'Do you want to reschedule your appointment with ${appointment.doctor.doctorName}?',
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            'Cancel',
            style: TextStyles.font14GrayRegular.copyWith(
              color: ColorsManager.gray,
            ),
          ),
        ),
        CustomMaterialButton(
          textButton: 'Reschedule',
          onPressed: () {
            context.pop();
            // TODO: Navigate to reschedule screen with appointment data
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Reschedule feature coming soon'),
                backgroundColor: Colors.orange,
              ),
            );
          },
          backgroundColor: ColorsManager.primaryColor,
          height: 40.h,
          minWidth: 120.w,
          raduisBorder: 8,
        ),
      ],
    );
  }
}
