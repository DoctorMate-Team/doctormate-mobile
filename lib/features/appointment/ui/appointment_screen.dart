import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_cubit.dart';
import 'package:doctor_mate/features/appointment/logic/cubit/appointment_state.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/app_bar_appointment_screen.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/custom_step_indicator.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/date_and_time/date_and_time_content.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/reason/reason_consultation_content.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/payment/payment_appointment_content.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/summary_booking/summary_appointment_content.dart';
import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppointmentScreen extends StatefulWidget {
  final DoctorDetailsModel? doctorDetails;

  const AppointmentScreen({super.key, this.doctorDetails});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Booking data
  String? selectedDate;
  String? selectedTime;
  int? selectedAppointmentType;
  String? selectedReason;
  String? selectedPaymentMethod;
  late String doctorId;
  List<String> workingDays = [];
  List<DateTime> availableSlots = [];

  final List<String> _stepTitles = [
    'Date & Time',
    'Reason',
    'Payment',
    'Summary',
  ];

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
          doctorId: doctorId,
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
    PaymentAppointmentContent(
      initialPayment: selectedPaymentMethod,
      onPaymentSelected:
          (payment) => setState(() => selectedPaymentMethod = payment),
    ),
    SummaryAppointmentContent(
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      selectedReason: selectedReason,
      appointmentType: selectedAppointmentType,
      selectedPaymentMethod: selectedPaymentMethod,
      doctorName: widget.doctorDetails?.fullName,
      doctorSpecialty: widget.doctorDetails?.specialty,
      doctorImage: widget.doctorDetails?.imageUrl,
      consultationFee: widget.doctorDetails?.consultationFee,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAppointment();
  }

  void _initializeAppointment() {
    // Get doctor ID from passed details
    doctorId = widget.doctorDetails?.id ?? '';
    workingDays = widget.doctorDetails?.workingDays ?? [];

    // Set first working day as default date if available
    if (workingDays.isNotEmpty) {
      final now = DateTime.now();
      final firstWorkingDay = workingDays.first;

      // Find the next occurrence of this working day
      DateTime nextDate = now;
      for (int i = 0; i < 7; i++) {
        final checkDate = now.add(Duration(days: i));
        final dayName = _getDayName(checkDate.weekday);
        if (dayName == firstWorkingDay) {
          nextDate = checkDate;
          break;
        }
      }

      selectedDate =
          '${nextDate.year}-${nextDate.month.toString().padLeft(2, '0')}-${nextDate.day.toString().padLeft(2, '0')}';

      // Fetch available slots for the default date
      if (doctorId.isNotEmpty) {
        context.read<AppointmentCubit>().getAvailableSlots(
          doctorId: doctorId,
          date: selectedDate!,
        );
      }
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
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
              content: Text('Please provide a reason for consultation'),
              backgroundColor: Colors.orange,
            ),
          );
          return false;
        }
        return true;
      case 2: // Payment step
        if (selectedPaymentMethod == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select a payment method'),
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
      _bookAppointment();
    }
  }

  void _bookAppointment() {
    if (selectedDate == null ||
        selectedTime == null ||
        selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final appointmentType =
        selectedAppointmentType == 0
            ? 'video'
            : selectedAppointmentType == 1
            ? 'voice'
            : 'in-person';

    context.read<AppointmentCubit>().bookAppointment(
      doctorId: doctorId,
      date: selectedDate!,
      time: selectedTime!,
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

    return BlocListener<AppointmentCubit, AppointmentState>(
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
          bookAppointmentLoading: () {
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
          bookAppointmentSuccess: (response) {
            Navigator.pop(context); // Close loading dialog
            context.pushNamed(
              Routes.bookingConfirmation,
              extra: response.appointment,
            );
          },
          bookAppointmentError: (message) {
            Navigator.pop(context); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: const AppBarAppointmentScreen(),
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
                        child: OutlinedButton(
                          onPressed: _previousStep,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            side: BorderSide(color: ColorsManager.primaryColor),
                          ),
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: ColorsManager.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    if (_currentStep > 0) horizantialSpacing(12),
                    Expanded(
                      flex: _currentStep > 0 ? 1 : 2,
                      child: CustomMaterialButton(
                        textButton: isLastStep ? 'Book Now' : 'Continue',
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
