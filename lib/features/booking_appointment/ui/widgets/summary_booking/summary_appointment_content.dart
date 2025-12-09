import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/core/widgets/horizantal_line_space.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/summary_booking/appointment_type_summary.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/summary_booking/date_and_time_summary.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/summary_booking/payment_type_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryAppointmentContent extends StatelessWidget {
  final String? selectedDate;
  final String? selectedTime;
  final String? selectedReason;
  final int? appointmentType;
  final String? selectedPaymentMethod;
  final String? doctorName;
  final String? doctorSpecialty;
  final String? doctorImage;
  final double? consultationFee;

  const SummaryAppointmentContent({
    super.key,
    this.selectedDate,
    this.selectedTime,
    this.selectedReason,
    this.appointmentType,
    this.selectedPaymentMethod,
    this.doctorName,
    this.doctorSpecialty,
    this.doctorImage,
    this.consultationFee,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Booking Information Card
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: ColorsManager.moreLighterGray,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.lightGray.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: ColorsManager.lighterMainBlue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: ColorsManager.primaryColor,
                        size: 20.sp,
                      ),
                    ),
                    horizantialSpacing(12),
                    Text(
                      'Booking Information',
                      style: TextStyles.font15DarkGreenMedium.copyWith(
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                  ],
                ),
                verticalSpacing(20),
                DateAndTimeSummary(
                  selectedDate: selectedDate,
                  selectedTime: selectedTime,
                ),
                verticalSpacing(16),
                const HorizantalLineSpace(),
                verticalSpacing(16),
                AppointmentTypeSummary(appointmentType: appointmentType ?? 0),
                verticalSpacing(16),
                const HorizantalLineSpace(),
                verticalSpacing(16),
                // Reason for consultation
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: ColorsManager.lighterMainBlue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        color: ColorsManager.primaryColor,
                        size: 18.sp,
                      ),
                    ),
                    horizantialSpacing(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reason for Consultation',
                            style: TextStyles.font14GreenSemiBold.copyWith(
                              color: ColorsManager.darkBlue,
                            ),
                          ),
                          verticalSpacing(4),
                          Text(
                            selectedReason ?? 'No reason provided',
                            style: TextStyles.font11GrayRegular,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          verticalSpacing(16),

          // Doctor Information Card
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: ColorsManager.moreLighterGray,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.lightGray.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: ColorsManager.lightGreen,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        color: ColorsManager.green,
                        size: 20.sp,
                      ),
                    ),
                    horizantialSpacing(12),
                    Text(
                      'Doctor Information',
                      style: TextStyles.font15DarkGreenMedium.copyWith(
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                  ],
                ),
                verticalSpacing(16),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          image:
                              doctorImage != null
                                  ? DecorationImage(
                                    image: NetworkImage(doctorImage!),
                                    fit: BoxFit.cover,
                                  )
                                  : null,
                          color:
                              doctorImage == null
                                  ? ColorsManager.moreLighterGray
                                  : null,
                        ),
                        child:
                            doctorImage == null
                                ? Icon(
                                  Icons.person,
                                  size: 30.sp,
                                  color: ColorsManager.lightGray,
                                )
                                : null,
                      ),
                    ),
                    horizantialSpacing(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorName ?? 'Doctor Name',
                            style: TextStyles.font14GreenSemiBold.copyWith(
                              color: ColorsManager.darkBlue,
                            ),
                          ),
                          verticalSpacing(4),
                          Text(
                            doctorSpecialty ?? 'Specialty',
                            style: TextStyles.font12GrayRegular,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          verticalSpacing(16),

          // Payment Information Card
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsManager.primaryColor.withOpacity(0.1),
                  ColorsManager.lighterMainBlue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: ColorsManager.primaryColor.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.payment_rounded,
                        color: ColorsManager.primaryColor,
                        size: 20.sp,
                      ),
                    ),
                    horizantialSpacing(12),
                    Text(
                      'Payment Information',
                      style: TextStyles.font15DarkGreenMedium.copyWith(
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                  ],
                ),
                verticalSpacing(16),
                PaymentTypeSummary(
                  paymentType: 0,
                  appointmentPrice: consultationFee?.toStringAsFixed(0) ?? '0',
                  paymentMethod: selectedPaymentMethod ?? 'Not selected',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
