import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/core/widgets/horizantal_line_space.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/summary_booking/appointment_type_summary.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/summary_booking/date_and_time_summary.dart';
import 'package:flutter/material.dart';

class BookingInformationAppointmentSummary extends StatelessWidget {
  const BookingInformationAppointmentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Booking Information',
          style: TextStyles.font15DarkGreenMedium
              .copyWith(fontWeight: FontWeightHelper.semiBold)),
      verticalSpacing(24),
      const DateAndTimeSummary(),
      verticalSpacing(16),
      const HorizantalLineSpace(),
      verticalSpacing(16),
      AppointmentTypeSummary(
                appointmentType: 0,
              ),
      verticalSpacing(16),
      const HorizantalLineSpace(),
    ]);
  }
}
