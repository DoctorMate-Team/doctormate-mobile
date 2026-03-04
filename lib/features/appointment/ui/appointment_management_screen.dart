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
  final int _pageLimit = 10;

  // Tracking for scheduled tab (fetches both 'scheduled' and 'confirmed')
  int _scheduledPendingRequests = 0;
  List<PatientAppointmentModel> _scheduledTempResults = [];
  bool _isScheduledInitialLoad = false;

  // Separate state for each tab
  final Map<String, List<PatientAppointmentModel>> _tabAppointments = {
    'scheduled': [],
    'inprogress': [],
    'completed': [],
    'cancelled': [],
  };

  final Map<String, int> _tabPages = {
    'scheduled': 1,
    'inprogress': 1,
    'completed': 1,
    'cancelled': 1,
  };

  final Map<String, bool> _tabHasMore = {
    'scheduled': true,
    'inprogress': true,
    'completed': true,
    'cancelled': true,
  };

  final Map<String, bool> _tabIsLoadingMore = {
    'scheduled': false,
    'inprogress': false,
    'completed': false,
    'cancelled': false,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_onTabChanged);
    // Fetch initial data for the first tab
    _fetchAppointments('scheduled', isInitial: true);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;

    final status = _getStatusFromTabIndex(_tabController.index);
    // Fetch data if this tab hasn't been loaded yet
    if (_tabAppointments[status]?.isEmpty ?? true) {
      _fetchAppointments(status, isInitial: true);
    }
  }

  String _getStatusFromTabIndex(int index) {
    switch (index) {
      case 0:
        return 'scheduled';
      case 1:
        return 'inprogress';
      case 2:
        return 'completed';
      case 3:
        return 'cancelled';
      default:
        return 'scheduled';
    }
  }

  void _fetchAppointments(String status, {bool isInitial = false}) {
    if (isInitial) {
      _tabPages[status] = 1;
    }

    // Special handling for scheduled tab: fetch both 'scheduled' and 'confirmed'
    if (status == 'scheduled') {
      _scheduledPendingRequests = 2;
      _scheduledTempResults = [];
      _isScheduledInitialLoad = isInitial || _tabPages[status] == 1;

      // Fetch 'scheduled' status
      context.read<AppointmentManageCubit>().getPatientAppointments(
        page: _tabPages[status]!,
        limit: _pageLimit,
        status: 'scheduled',
      );

      // Fetch 'confirmed' status
      context.read<AppointmentManageCubit>().getPatientAppointments(
        page: _tabPages[status]!,
        limit: _pageLimit,
        status: 'confirmed',
      );
    } else {
      // Other tabs: single request
      context.read<AppointmentManageCubit>().getPatientAppointments(
        page: _tabPages[status]!,
        limit: _pageLimit,
        status: status,
      );
    }
  }

  void _loadMoreAppointments(String status) {
    if (_tabIsLoadingMore[status]! || !_tabHasMore[status]!) return;

    setState(() {
      _tabIsLoadingMore[status] = true;
      _tabPages[status] = _tabPages[status]! + 1;
    });

    _fetchAppointments(status);
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
            final currentStatus = _getStatusFromTabIndex(_tabController.index);

            // Handle scheduled tab (accumulate results from both calls)
            if (currentStatus == 'scheduled' && _scheduledPendingRequests > 0) {
              _scheduledTempResults.addAll(response.appointments);
              _scheduledPendingRequests--;

              // If both requests complete, update state
              if (_scheduledPendingRequests == 0) {
                // Sort by date (newest first)
                _scheduledTempResults.sort(
                  (a, b) => b.appointmentDate.compareTo(a.appointmentDate),
                );

                setState(() {
                  if (_isScheduledInitialLoad || _tabPages['scheduled'] == 1) {
                    _tabAppointments['scheduled'] = _scheduledTempResults;
                  } else {
                    _tabAppointments['scheduled']!.addAll(
                      _scheduledTempResults,
                    );
                  }

                  // Update hasMore flag based on total results
                  _tabHasMore['scheduled'] =
                      _scheduledTempResults.length >= _pageLimit;
                  _tabIsLoadingMore['scheduled'] = false;
                  _scheduledTempResults = [];
                });
              }
              return;
            }

            // Handle other tabs normally
            setState(() {
              if (_tabPages[currentStatus] == 1) {
                // Initial load or refresh
                _tabAppointments[currentStatus] = response.appointments;
              } else {
                // Load more
                _tabAppointments[currentStatus]!.addAll(response.appointments);
              }

              // Update hasMore flag
              _tabHasMore[currentStatus] =
                  response.appointments.length >= _pageLimit;
              _tabIsLoadingMore[currentStatus] = false;
            });
          },
          errorAppointmentsPatient: (message) {
            final currentStatus = _getStatusFromTabIndex(_tabController.index);

            // Handle errors for scheduled tab
            if (currentStatus == 'scheduled' && _scheduledPendingRequests > 0) {
              _scheduledPendingRequests--;

              // If both requests complete (even with errors), reset state
              if (_scheduledPendingRequests == 0) {
                setState(() {
                  _tabIsLoadingMore['scheduled'] = false;
                  _scheduledTempResults = [];
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message), backgroundColor: Colors.red),
                );
              }
              return;
            }

            // Handle errors for other tabs
            setState(() {
              _tabIsLoadingMore[currentStatus] = false;
            });
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
            // Refresh current tab
            final currentStatus = _getStatusFromTabIndex(_tabController.index);
            _fetchAppointments(currentStatus, isInitial: true);
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
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AppointmentListView(
                    status: 'scheduled',
                    appointments: _tabAppointments['scheduled']!,
                    onRefresh:
                        () => _fetchAppointments('scheduled', isInitial: true),
                    onCancel: _showCancelDialog,
                    onLoadMore: () => _loadMoreAppointments('scheduled'),
                    hasMore: _tabHasMore['scheduled']!,
                    isLoadingMore: _tabIsLoadingMore['scheduled']!,
                  ),
                  AppointmentListView(
                    status: 'inprogress',
                    appointments: _tabAppointments['inprogress']!,
                    onRefresh:
                        () => _fetchAppointments('inprogress', isInitial: true),
                    onCancel: _showCancelDialog,
                    onLoadMore: () => _loadMoreAppointments('inprogress'),
                    hasMore: _tabHasMore['inprogress']!,
                    isLoadingMore: _tabIsLoadingMore['inprogress']!,
                  ),
                  AppointmentListView(
                    status: 'completed',
                    appointments: _tabAppointments['completed']!,
                    onRefresh:
                        () => _fetchAppointments('completed', isInitial: true),
                    onCancel: _showCancelDialog,
                    onLoadMore: () => _loadMoreAppointments('completed'),
                    hasMore: _tabHasMore['completed']!,
                    isLoadingMore: _tabIsLoadingMore['completed']!,
                  ),
                  AppointmentListView(
                    status: 'cancelled',
                    appointments: _tabAppointments['cancelled']!,
                    onRefresh:
                        () => _fetchAppointments('cancelled', isInitial: true),
                    onCancel: _showCancelDialog,
                    onLoadMore: () => _loadMoreAppointments('cancelled'),
                    hasMore: _tabHasMore['cancelled']!,
                    isLoadingMore: _tabIsLoadingMore['cancelled']!,
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
}
