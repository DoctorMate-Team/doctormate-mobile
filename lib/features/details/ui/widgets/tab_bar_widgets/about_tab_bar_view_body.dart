import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/details/data/models/doctor_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AboutTabBarViewBody extends StatelessWidget {
  final DoctorDetailsModel doctor;

  const AboutTabBarViewBody({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Doctor',
            style: TextStyles.font16DarkGreenBold.copyWith(
              fontWeight: FontWeightHelper.bold,
              fontSize: 18.sp,
            ),
          ),
          verticalSpacing(12),
          Text(
            "${doctor.fullName} is a highly qualified and experienced ${doctor.specialty} with extensive practice. Dedicated to providing excellent care and continuous learning to help patients achieve better health outcomes.",
            style: TextStyles.font14GrayRegular.copyWith(height: 1.6),
          ),
          verticalSpacing(24),

          _buildWorkingTimeCard(doctor),
          verticalSpacing(12),

          _buildInfoCard(
            icon: Iconsax.call,
            title: 'Phone Number',
            subtitle: 'Direct line',
            value: doctor.phoneNumber,
            color: Colors.blue,
          ),
          verticalSpacing(12),

          _buildInfoCard(
            icon: Iconsax.location,
            title: 'Location',
            subtitle: 'Clinic Address',
            value: doctor.address,
            color: Colors.orange,
          ),
          verticalSpacing(12),

          _buildInfoCard(
            icon: Iconsax.award,
            title: 'Qualifications',
            subtitle: 'Medical Degree',
            value: doctor.qualifications,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          horizantialSpacing(16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.font14DarkGreenMedium.copyWith(
                    fontWeight: FontWeightHelper.semiBold,
                  ),
                ),
                verticalSpacing(4),
                Text(subtitle, style: TextStyles.font12GrayRegular),
              ],
            ),
          ),
          horizantialSpacing(8),
          Flexible(
            child: Text(
              value,
              style: TextStyles.font14DarkGreenMedium.copyWith(
                fontWeight: FontWeightHelper.semiBold,
                color: color,
                fontSize: 13.sp,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingTimeCard(DoctorDetailsModel doctor) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primaryColor.withOpacity(0.05),
            ColorsManager.lighterMainBlue.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.primaryColor.withOpacity(0.15),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Iconsax.clock,
                  color: ColorsManager.primaryColor,
                  size: 24.sp,
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Working Hours',
                      style: TextStyles.font14DarkGreenMedium.copyWith(
                        fontWeight: FontWeightHelper.semiBold,
                        fontSize: 15.sp,
                      ),
                    ),
                    verticalSpacing(4),
                    Text(
                      'Schedule & Availability',
                      style: TextStyles.font12GrayRegular.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              horizantialSpacing(8),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: ColorsManager.green.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: ColorsManager.green,
                        size: 14.sp,
                      ),
                      horizantialSpacing(4),
                      Flexible(
                        child: Text(
                          'Available',
                          style: TextStyles.font12GrayRegular.copyWith(
                            color: ColorsManager.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.calendar_1,
                      color: ColorsManager.primaryColor,
                      size: 18.sp,
                    ),
                    horizantialSpacing(8),
                    Text(
                      'Working Days:',
                      style: TextStyles.font12GrayRegular.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.darkBlue,
                      ),
                    ),
                  ],
                ),
                verticalSpacing(8),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children:
                      doctor.workingDays.map((day) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: ColorsManager.primaryColor.withOpacity(
                                0.3,
                              ),
                            ),
                          ),
                          child: Text(
                            day,
                            style: TextStyles.font12GrayRegular.copyWith(
                              color: ColorsManager.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                ),
                verticalSpacing(12),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsManager.primaryColor.withOpacity(0.1),
                        ColorsManager.green.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.timer_1,
                        color: ColorsManager.primaryColor,
                        size: 18.sp,
                      ),
                      horizantialSpacing(8),
                      Text(
                        doctor.workingTime,
                        style: TextStyles.font14DarkGreenMedium.copyWith(
                          fontWeight: FontWeightHelper.bold,
                          color: ColorsManager.primaryColor,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
