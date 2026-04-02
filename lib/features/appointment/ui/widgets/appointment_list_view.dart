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

class AppointmentListView extends StatefulWidget {
  final String status;
  final List<PatientAppointmentModel> appointments;
  final VoidCallback onRefresh;
  final Function(PatientAppointmentModel) onCancel;
  final VoidCallback onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;

  const AppointmentListView({
    super.key,
    required this.status,
    required this.appointments,
    required this.onRefresh,
    required this.onCancel,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoadingMore,
  });

  @override
  State<AppointmentListView> createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      // User has scrolled to 90% of the list - load more
      if (widget.hasMore && !widget.isLoadingMore) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentManageCubit, AppointmentManageState>(
      buildWhen:
          (previous, current) =>
              current is LoadedAppointmentsPatient ||
              current is ErrorAppointmentsPatient ||
              current is LoadingAppointmentsPatient,
      builder: (context, state) {
        return state.maybeWhen(
          loadingAppointmentsPatient: () {
            // Only show shimmer loading if it's the initial load
            if (widget.appointments.isEmpty) {
              return const AppointmentShimmerLoading();
            }
            // If we have data and loading more, show the list with loading indicator
            return _buildAppointmentList();
          },
          loadedAppointmentsPatient: (_) => _buildAppointmentList(),
          errorAppointmentsPatient:
              (message) => AppointmentErrorState(
                message: message,
                onRetry: widget.onRefresh,
              ),
          orElse: () => const AppointmentShimmerLoading(),
        );
      },
    );
  }

  Widget _buildAppointmentList() {
    if (widget.appointments.isEmpty) {
      return AppointmentEmptyState(status: widget.status);
    }

    return RefreshIndicator(
      onRefresh: () async {
        widget.onRefresh();
      },
      color: ColorsManager.primaryColor,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(16.w),
        itemCount: widget.appointments.length + (widget.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Show appointment card
          if (index < widget.appointments.length) {
            return AppointmentCard(
              appointment: widget.appointments[index],
              status: widget.status,
              onCancel: () => widget.onCancel(widget.appointments[index]),
              onRefresh: widget.onRefresh,
            );
          }

          // Show loading indicator at the bottom
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
