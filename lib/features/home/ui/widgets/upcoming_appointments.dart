import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_cubit.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<AppointmentManageCubit>()..getPatientAppointments(
                page: 1,
                limit: 1,
                status: 'confirmed',
              ),
      child: const _UpcomingAppointmentContent(),
    );
  }
}

class _UpcomingAppointmentContent extends StatelessWidget {
  const _UpcomingAppointmentContent();

  String _formatAppointmentDate(DateTime date, String time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDay = DateTime(date.year, date.month, date.day);

    if (appointmentDay == today) {
      return 'Today, $time';
    } else if (appointmentDay == today.add(const Duration(days: 1))) {
      return 'Tomorrow, $time';
    } else {
      return '${DateFormat('MMM dd').format(date)}, $time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentManageCubit, AppointmentManageState>(
      builder: (context, state) {
        return state.maybeWhen(
          loadingAppointmentsPatient: () => _buildShimmerLoading(),
          loadedAppointmentsPatient: (response) {
            if (response.appointments.isEmpty) {
              return _buildEmptyState();
            }
            final appointment = response.appointments.first;
            return _buildAppointmentCard(context, appointment);
          },
          errorAppointmentsPatient: (message) => _buildErrorState(message),
          orElse: () => _buildShimmerLoading(),
        );
      },
    );
  }

  Widget _buildAppointmentCard(
    BuildContext context,
    PatientAppointmentModel appointment,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to main layout and switch to appointments tab (index 2)
        context.pushNamed(Routes.mainLayout, extra: 1);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorsManager.primaryColor.withOpacity(0.02),
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: ColorsManager.primaryColor.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.primaryColor.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative circle pattern
            Positioned(
              top: -20.h,
              right: -20.w,
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.primaryColor.withOpacity(0.05),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Doctor Image with enhanced styling
                      Stack(
                        children: [
                          Container(
                            width: 70.w,
                            height: 70.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorsManager.primaryColor.withOpacity(0.1),
                                  ColorsManager.primaryColor.withOpacity(0.05),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorsManager.primaryColor.withOpacity(
                                    0.2,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: CachedNetworkImage(
                                imageUrl: appointment.doctor.image,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: ColorsManager.primaryColor,
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) => Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            ColorsManager.primaryColor
                                                .withOpacity(0.2),
                                            ColorsManager.primaryColor
                                                .withOpacity(0.1),
                                          ],
                                        ),
                                      ),
                                      child: Icon(
                                        Iconsax.user,
                                        size: 32.sp,
                                        color: ColorsManager.primaryColor,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          // Online indicator
                          Positioned(
                            bottom: 2.h,
                            right: 2.w,
                            child: Container(
                              width: 16.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.4),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      horizantialSpacing(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.doctor.doctorName,
                              style: TextStyles.font18DarkGreenBold.copyWith(
                                fontSize: 17.sp,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalSpacing(6),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.blue.shade100,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Iconsax.health,
                                    size: 12.sp,
                                    color: Colors.blue.shade700,
                                  ),
                                  horizantialSpacing(4),
                                  Flexible(
                                    child: Text(
                                      appointment.doctor.specialtyName,
                                      style: TextStyles.font12DarkGreenSemiBold
                                          .copyWith(
                                            color: Colors.blue.shade700,
                                            fontSize: 11.sp,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  verticalSpacing(16),

                  // Divider with gradient
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.grey.shade300,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  verticalSpacing(16),

                  // Bottom info section
                  Row(
                    children: [
                      // Date & Time
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: ColorsManager.primaryColor.withOpacity(
                                0.15,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: ColorsManager.primaryColor.withOpacity(
                                    0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Iconsax.calendar_1,
                                  size: 16.sp,
                                  color: ColorsManager.primaryColor,
                                ),
                              ),
                              horizantialSpacing(8),
                              Flexible(
                                child: Text(
                                  _formatAppointmentDate(
                                    appointment.appointmentDate,
                                    appointment.appointmentTime,
                                  ),
                                  style: TextStyles.font14DarkGreenMedium
                                      .copyWith(fontSize: 13.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      horizantialSpacing(12),

                      // Confirmed status with enhanced styling
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade400,
                              Colors.green.shade500,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Iconsax.tick_circle,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                            horizantialSpacing(6),
                            Text(
                              'Confirmed',
                              style: TextStyles.font12DarkGreenSemiBold
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      width: double.infinity,
      height: 100.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          horizantialSpacing(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                verticalSpacing(8),
                Container(
                  width: 120.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.calendar_search,
              size: 40.sp,
              color: Colors.grey.shade400,
            ),
          ),
          verticalSpacing(16),
          Text(
            'No Upcoming Appointments',
            style: TextStyles.font16DarkGreenBold.copyWith(
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpacing(6),
          Text(
            'Book an appointment to see it here',
            style: TextStyles.font12GrayRegular.copyWith(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.red.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.info_circle,
              size: 36.sp,
              color: Colors.red.shade400,
            ),
          ),
          verticalSpacing(16),
          Text(
            'Unable to Load',
            style: TextStyles.font16DarkGreenBold.copyWith(
              color: Colors.red.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpacing(6),
          Text(
            'Please check your connection',
            style: TextStyles.font12GrayRegular.copyWith(
              color: Colors.red.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
