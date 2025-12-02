import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/date_and_time/appointment_type_list.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/date_and_time/date_picker_list_view.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/date_and_time/time_picker_grid_view.dart';
import 'package:flutter/material.dart';

class DateAndTimeContent extends StatelessWidget {
  const DateAndTimeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DatePickerListView(),
          verticalSpacing(32),
          const TimePickerGridView(),
          verticalSpacing(32),
          const AppointmentTypeList(),
        ],
      ),
    );
  }
}
