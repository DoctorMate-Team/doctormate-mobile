import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/date_and_time/date_picker_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DatePickerListView extends StatefulWidget {
  final Function(String)? onDateSelected;
  final List<String> workingDays;
  final String? initialDate;

  const DatePickerListView({
    super.key,
    this.onDateSelected,
    this.workingDays = const [],
    this.initialDate,
  });

  @override
  State<DatePickerListView> createState() => _DatePickerListViewState();
}

class _DatePickerListViewState extends State<DatePickerListView> {
  DateTime? selectedDate;
  late List<DateTime> dates;
  DateTime currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _generateDates();
    _initializeSelection();
  }

  void _initializeSelection() {
    // Set initial date if provided
    if (widget.initialDate != null) {
      try {
        final parts = widget.initialDate!.split('-');
        if (parts.length == 3) {
          selectedDate = DateTime(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
        }
      } catch (e) {
        // Invalid date format, ignore
      }
    }
  }

  @override
  void didUpdateWidget(DatePickerListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.workingDays != widget.workingDays) {
      _generateDates();
    }
    // Update selection if initial date changed
    if (oldWidget.initialDate != widget.initialDate &&
        widget.initialDate != null) {
      _initializeSelection();
    }
  }

  void _generateDates() {
    final now = DateTime.now();
    dates = [];

    // If no working days specified, show all dates
    if (widget.workingDays.isEmpty) {
      dates = List.generate(30, (index) => now.add(Duration(days: index)));
      return;
    }

    // Filter dates to only show working days
    for (int i = 0; i < 60; i++) {
      final date = now.add(Duration(days: i));
      final dayName = _getDayName(date.weekday);

      if (widget.workingDays.contains(dayName)) {
        dates.add(date);
      }

      // Stop when we have enough working days
      if (dates.length >= 30) break;
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

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Date',
              style: TextStyles.font15DarkGreenMedium.copyWith(
                fontWeight: FontWeightHelper.semiBold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _previousMonth,
                  icon: const Icon(
                    Iconsax.arrow_left_2,
                    color: ColorsManager.primaryColor,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 20,
                ),
                horizantialSpacing(12),
                Text(
                  '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
                  style: TextStyles.font14GreenSemiBold,
                ),
                horizantialSpacing(12),
                IconButton(
                  onPressed: _nextMonth,
                  icon: const Icon(
                    Iconsax.arrow_right_3,
                    color: ColorsManager.primaryColor,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 20,
                ),
              ],
            ),
          ],
        ),
        verticalSpacing(16),
        SizedBox(
          height: 110.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            separatorBuilder: (context, index) => horizantialSpacing(12),
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected =
                  selectedDate != null &&
                  date.year == selectedDate!.year &&
                  date.month == selectedDate!.month &&
                  date.day == selectedDate!.day;

              return DatePickerAppointmentScreen(
                date: date,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    selectedDate = date;
                  });
                  // Send formatted date (YYYY-MM-DD)
                  widget.onDateSelected?.call(
                    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
