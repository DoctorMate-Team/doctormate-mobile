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

          _buildInfoCard(
            icon: Iconsax.clock,
            title: 'Working Time',
            subtitle: 'Monday - Friday',
            value: doctor.workingTime,
            color: ColorsManager.primaryColor,
          ),
          verticalSpacing(12),

          _buildInfoCard(
            icon: Iconsax.call,
            title: 'Phone Number',
            subtitle: 'Direct line',
            value: '+1 (123) 456-7890',
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
            value: 'MD, FACC',
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
          Text(
            value,
            style: TextStyles.font14DarkGreenMedium.copyWith(
              fontWeight: FontWeightHelper.semiBold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
