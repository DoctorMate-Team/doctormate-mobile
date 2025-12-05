import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/appointment/ui/widgets/date_and_time/time_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePickerGridView extends StatefulWidget {
  final Function(String)? onTimeSelected;
  final List<DateTime> availableSlots;
  final String? initialTime;

  const TimePickerGridView({
    super.key,
    this.onTimeSelected,
    this.availableSlots = const [],
    this.initialTime,
  });

  @override
  State<TimePickerGridView> createState() => _TimePickerGridViewState();
}

class _TimePickerGridViewState extends State<TimePickerGridView> {
  int? selectedTimeIndex;
  late List<DateTime> morningSlots;
  late List<DateTime> afternoonSlots;
  late List<DateTime> eveningSlots;

  @override
  void initState() {
    super.initState();
    _categorizeSlots();
    _initializeSelection();
  }

  void _initializeSelection() {
    if (widget.initialTime != null && widget.availableSlots.isNotEmpty) {
      // Parse initial time (HH:mm:ss format)
      try {
        final parts = widget.initialTime!.split(':');
        if (parts.length >= 2) {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);

          // Find matching slot and set index
          for (int i = 0; i < widget.availableSlots.length; i++) {
            final slot = widget.availableSlots[i];
            if (slot.hour == hour && slot.minute == minute) {
              setState(() {
                selectedTimeIndex = i;
              });
              break;
            }
          }
        }
      } catch (e) {
        // Invalid time format, ignore
      }
    }
  }

  @override
  void didUpdateWidget(TimePickerGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.availableSlots != widget.availableSlots) {
      _categorizeSlots();
      // Don't reset selection, try to restore it
      _initializeSelection();
    }
    // Update selection if initial time changed
    if (oldWidget.initialTime != widget.initialTime &&
        widget.initialTime != null) {
      _initializeSelection();
    }
  }

  void _categorizeSlots() {
    morningSlots = [];
    afternoonSlots = [];
    eveningSlots = [];

    for (final slot in widget.availableSlots) {
      final hour = slot.hour;

      if (hour >= 6 && hour < 12) {
        morningSlots.add(slot);
      } else if (hour >= 12 && hour < 17) {
        afternoonSlots.add(slot);
      } else if (hour >= 17 && hour < 22) {
        eveningSlots.add(slot);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show message if no slots available
    if (widget.availableSlots.isEmpty) {
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
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Column(
                children: [
                  Icon(
                    Icons.schedule_outlined,
                    size: 48.sp,
                    color: Colors.grey,
                  ),
                  verticalSpacing(12),
                  Text(
                    'Please select a date to see available time slots',
                    style: TextStyles.font14GreenSemiBold.copyWith(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

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
        if (morningSlots.isNotEmpty) ...[
          _buildTimeSection(
            'Morning',
            morningSlots,
            Icons.wb_sunny_outlined,
            0,
          ),
          verticalSpacing(20),
        ],
        if (afternoonSlots.isNotEmpty) ...[
          _buildTimeSection(
            'Afternoon',
            afternoonSlots,
            Icons.wb_twilight_outlined,
            morningSlots.length,
          ),
          verticalSpacing(20),
        ],
        if (eveningSlots.isNotEmpty) ...[
          _buildTimeSection(
            'Evening',
            eveningSlots,
            Icons.nightlight_outlined,
            morningSlots.length + afternoonSlots.length,
          ),
        ],
      ],
    );
  }

  Widget _buildTimeSection(
    String title,
    List<DateTime> slots,
    IconData icon,
    int baseIndex,
  ) {
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
          itemCount: slots.length,
          itemBuilder: (context, index) {
            final globalIndex = baseIndex + index;
            final slot = slots[index];
            final timeString =
                '${slot.hour.toString().padLeft(2, '0')}:${slot.minute.toString().padLeft(2, '0')}';

            return TimeAppointmentScreen(
              time: timeString,
              isSelected: selectedTimeIndex == globalIndex,
              isPastTime: false, // All API slots are valid
              onTap: () {
                setState(() {
                  selectedTimeIndex = globalIndex;
                });
                // Send formatted time (HH:mm:ss)
                widget.onTimeSelected?.call(
                  '${slot.hour.toString().padLeft(2, '0')}:${slot.minute.toString().padLeft(2, '0')}:00',
                );
              },
            );
          },
        ),
      ],
    );
  }
}
