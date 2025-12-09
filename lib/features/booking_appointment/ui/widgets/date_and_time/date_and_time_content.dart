import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/date_and_time/appointment_type_list.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/date_and_time/date_picker_list_view.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/date_and_time/time_picker_grid_view.dart';
import 'package:flutter/material.dart';

class DateAndTimeContent extends StatelessWidget {
  final Function(String)? onDateSelected;
  final Function(String)? onTimeSelected;
  final Function(int)? onTypeSelected;
  final List<String> workingDays;
  final List<DateTime> availableSlots;
  final String? initialDate;
  final String? initialTime;
  final int? initialType;

  const DateAndTimeContent({
    super.key,
    this.onDateSelected,
    this.onTimeSelected,
    this.onTypeSelected,
    this.workingDays = const [],
    this.availableSlots = const [],
    this.initialDate,
    this.initialTime,
    this.initialType,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DatePickerListView(
            onDateSelected: onDateSelected,
            workingDays: workingDays,
            initialDate: initialDate,
          ),
          verticalSpacing(32),
          TimePickerGridView(
            onTimeSelected: onTimeSelected,
            availableSlots: availableSlots,
            initialTime: initialTime,
          ),
          verticalSpacing(32),
          AppointmentTypeList(
            onTypeSelected: onTypeSelected,
            initialType: initialType,
          ),
        ],
      ),
    );
  }
}
