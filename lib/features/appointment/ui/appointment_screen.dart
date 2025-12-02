import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/app_bar_appointment_screen.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/custom_step_indicator.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/date_and_time/date_and_time_content.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/reason/reason_consultation_content.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/payment/payment_appointment_content.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/summary_booking/summary_appointment_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _currentStep = 0;
  final int _totalSteps = 4;

  final List<String> _stepTitles = [
    'Date & Time',
    'Reason',
    'Payment',
    'Summary',
  ];

  final List<Widget> _stepContents = [
    const DateAndTimeContent(),
    const ReasonConsultationContent(),
    const PaymentAppointmentContent(),
    const SummaryAppointmentContent(),
  ];

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      context.pushNamed(Routes.bookingConfirmation);
    }
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

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: const AppBarAppointmentScreen(),
            ),
            CustomStepIndicator(currentStep: _currentStep, steps: _stepTitles),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
    );
  }
}
