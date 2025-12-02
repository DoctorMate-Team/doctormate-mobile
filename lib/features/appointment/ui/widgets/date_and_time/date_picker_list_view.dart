import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/date_and_time/date_picker_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DatePickerListView extends StatefulWidget {
  const DatePickerListView({super.key});

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
  }

  void _generateDates() {
    final now = DateTime.now();
    dates = List.generate(30, (index) => now.add(Duration(days: index)));
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
