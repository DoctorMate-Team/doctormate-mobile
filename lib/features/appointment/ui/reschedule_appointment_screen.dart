import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_cubit.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_manage_state.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_cubit.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_state.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/app_bar_appointment_screen.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/custom_step_indicator.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/date_and_time/date_and_time_content.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/reason/reason_consultation_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RescheduleAppointmentScreen extends StatefulWidget {
  final PatientAppointmentModel appointment;

  const RescheduleAppointmentScreen({super.key, required this.appointment});

  @override
  State<RescheduleAppointmentScreen> createState() =>
      _RescheduleAppointmentScreenState();
}

class _RescheduleAppointmentScreenState
    extends State<RescheduleAppointmentScreen> {
  int _currentStep = 0;
  final int _totalSteps = 2; // Only Date/Time and Reason

  // Booking data
  String? selectedDate;
  String? selectedTime;
  int? selectedAppointmentType;
  String? selectedReason;
  List<String> workingDays = [];
  List<DateTime> availableSlots = [];

  final List<String> _stepTitles = ['Date & Time', 'Reason'];

  List<Widget> get _stepContents => [
    DateAndTimeContent(
      workingDays: workingDays,
      availableSlots: availableSlots,
      initialDate: selectedDate,
      initialTime: selectedTime,
      initialType: selectedAppointmentType,
      onDateSelected: (date) {
        setState(() => selectedDate = date);
        // Fetch available slots when date changes
        context.read<AppointmentCubit>().getAvailableSlots(
          doctorId: widget.appointment.doctor.id,
          date: date,
        );
      },
      onTimeSelected: (time) => setState(() => selectedTime = time),
      onTypeSelected: (type) => setState(() => selectedAppointmentType = type),
    ),
    ReasonConsultationContent(
      initialReason: selectedReason,
      onReasonSelected: (reason) => setState(() => selectedReason = reason),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeReschedule();
  }

  void _initializeReschedule() {
    // Pre-fill with current appointment data
    // Convert DateTime to String format
    selectedDate = widget.appointment.appointmentDate.toString().split(' ')[0];
    selectedTime = widget.appointment.appointmentTime;
    selectedReason = widget.appointment.reason;

    // Note: Appointment type is not stored in the appointment response,
    // so we don't pre-fill it. User will need to select it again.
    selectedAppointmentType = null;

    // Note: Working days are not available in appointment doctor model,
    // DatePickerListView will use default logic
    workingDays = [];

    // Fetch available slots for the current date
    context.read<AppointmentCubit>().getAvailableSlots(
      doctorId: widget.appointment.doctor.id,
      date: selectedDate!,
    );
  }

  String _getAppointmentTypeString(int index) {
    switch (index) {
      case 0:
        return 'video';
      case 1:
        return 'voice';
      case 2:
        return 'in_person';
      default:
        return 'video';
    }
  }

  bool _canProceedToNextStep() {
    switch (_currentStep) {
      case 0: // Date & Time step
        if (selectedDate == null ||
            selectedTime == null ||
            selectedAppointmentType == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select date, time, and appointment type'),
              backgroundColor: Colors.orange,
            ),
          );
          return false;
        }
        return true;
      case 1: // Reason step
        if (selectedReason == null || selectedReason!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please provide a reason for rescheduling'),
              backgroundColor: Colors.orange,
            ),
          );
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _nextStep() {
    if (!_canProceedToNextStep()) {
      return;
    }

    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _rescheduleAppointment();
    }
  }

  void _rescheduleAppointment() {
    if (selectedDate == null ||
        selectedTime == null ||
        selectedReason == null ||
        selectedAppointmentType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final appointmentType = _getAppointmentTypeString(selectedAppointmentType!);

    context.read<AppointmentManageCubit>().rescheduleAppointment(
      appointmentId: widget.appointment.id,
      newDate: selectedDate!,
      newTime: selectedTime!,
      reason: selectedReason!,
      appointmentType: appointmentType,
    );
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastStep = _currentStep == _totalSteps - 1;

    return MultiBlocListener(
      listeners: [
        BlocListener<AppointmentCubit, AppointmentState>(
          listenWhen:
              (previous, current) =>
                  current is AvailableSlotsLoaded ||
                  current is AvailableSlotsError,
          listener: (context, state) {
            state.whenOrNull(
              availableSlotsLoaded: (slots) {
                setState(() {
                  availableSlots = slots.slots;
                });
              },
              availableSlotsError: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to load slots: $message'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
            );
          },
        ),
        BlocListener<AppointmentManageCubit, AppointmentManageState>(
          listenWhen:
              (previous, current) =>
                  current is ReschedulingAppointment ||
                  current is RescheduledAppointment ||
                  current is ErrorReschedulingAppointment,
          listener: (context, state) {
            state.whenOrNull(
              reschedulingAppointment: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (context) => const Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                );
              },
              rescheduledAppointment: (appointment) {
                Navigator.pop(context); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Appointment rescheduled successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                // Go back and refresh the appointments list
                context.pop(true); // Return true to indicate success
              },
              errorReschedulingAppointment: (message) {
                Navigator.pop(context); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message), backgroundColor: Colors.red),
                );
              },
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    const AppBarAppointmentScreen(
                      title: 'Reschedule Appointment',
                    ),
                    verticalSpacing(12),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.blue.shade700,
                              size: 20.sp,
                            ),
                          ),
                          horizantialSpacing(12),
                          Expanded(
                            child: Text(
                              'Rescheduling appointment with Dr. ${widget.appointment.doctor.doctorName}',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomStepIndicator(
                currentStep: _currentStep,
                steps: _stepTitles,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _stepContents[_currentStep],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: CustomMaterialButton(
                          textButton: 'Back',
                          onPressed: _previousStep,
                          backgroundColor: Colors.grey.shade100,
                          textColor: Colors.black87,
                        ),
                      ),
                    if (_currentStep > 0) horizantialSpacing(12),
                    Expanded(
                      flex: _currentStep > 0 ? 1 : 2,
                      child: CustomMaterialButton(
                        textButton: isLastStep ? 'Reschedule' : 'Continue',
                        onPressed: _nextStep,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
