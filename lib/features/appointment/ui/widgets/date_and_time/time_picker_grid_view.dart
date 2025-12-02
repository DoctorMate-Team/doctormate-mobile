import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/date_and_time/time_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePickerGridView extends StatefulWidget {
  const TimePickerGridView({super.key});
  @override
  State<TimePickerGridView> createState() => _TimePickerGridViewState();
}

class _TimePickerGridViewState extends State<TimePickerGridView> {
  int? selectedTimeIndex;
  late List<TimeOfDay> morningTimes;
  late List<TimeOfDay> afternoonTimes;
  late List<TimeOfDay> eveningTimes;

  @override
  void initState() {
    super.initState();
    _generateTimeSlots();
  }

  void _generateTimeSlots() {
    morningTimes = _generateTimeRange(8, 12); // 8 AM - 11:30 AM
    afternoonTimes = _generateTimeRange(12, 17); // 12 PM - 4:30 PM
    eveningTimes = _generateTimeRange(17, 21); // 5 PM - 8:30 PM
  }

  List<TimeOfDay> _generateTimeRange(int startHour, int endHour) {
    List<TimeOfDay> times = [];
    for (int hour = startHour; hour < endHour; hour++) {
      times.add(TimeOfDay(hour: hour, minute: 0));
      times.add(TimeOfDay(hour: hour, minute: 30));
    }
    return times;
  }

  bool _isPastTime(TimeOfDay time) {
    final now = TimeOfDay.now();
    final timeInMinutes = time.hour * 60 + time.minute;
    final nowInMinutes = now.hour * 60 + now.minute;
    return timeInMinutes < nowInMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Time',
          style: TextStyles.font15DarkGreenMedium.copyWith(
            fontWeight: FontWeightHelper.semiBold,
          ),
        ),
        verticalSpacing(16),
        _buildTimeSection('Morning', morningTimes, Icons.wb_sunny_outlined),
        verticalSpacing(20),
        _buildTimeSection(
          'Afternoon',
          afternoonTimes,
          Icons.wb_twilight_outlined,
        ),
        verticalSpacing(20),
        _buildTimeSection('Evening', eveningTimes, Icons.nightlight_outlined),
      ],
    );
  }

  Widget _buildTimeSection(String title, List<TimeOfDay> times, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: ColorsManager.primaryColor, size: 18.sp),
            horizantialSpacing(8),
            Text(
              title,
              style: TextStyles.font14GreenSemiBold.copyWith(
                color: ColorsManager.darkBlue,
              ),
            ),
          ],
        ),
        verticalSpacing(12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 2.2,
          ),
          itemCount: times.length,
          itemBuilder: (context, index) {
            final globalIndex =
                morningTimes.length *
                    (title == 'Morning'
                        ? 0
                        : title == 'Afternoon'
                        ? 1
                        : 2) +
                index;
            final time = times[index];
            final timeString = time.format(context);
            final isPast = _isPastTime(time);

            return TimeAppointmentScreen(
              time: timeString,
              isSelected: selectedTimeIndex == globalIndex,
              isPastTime: isPast,
              onTap: () {
                setState(() {
                  selectedTimeIndex = globalIndex;
                });
              },
            );
          },
        ),
      ],
    );
  }
}
