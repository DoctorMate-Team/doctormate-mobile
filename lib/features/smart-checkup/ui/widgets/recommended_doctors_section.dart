import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/smart-checkup/data/models/smart_check_response.dart';
import 'package:doctor_mate/features/smart-checkup/ui/widgets/recommended_doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RecommendedDoctorsSection extends StatelessWidget {
  final List<RecommendedDoctorModel> doctors;

  const RecommendedDoctorsSection({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Iconsax.user_octagon,
              color: ColorsManager.primaryColor,
              size: 24.sp,
            ),
            horizantialSpacing(8),
            Text('Recommended Doctors', style: TextStyles.font18DarkGreenBold),
          ],
        ),
        verticalSpacing(8),
        Text(
          'Top specialists for your condition',
          style: TextStyles.font14DarkGreenMedium.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        verticalSpacing(16),
        ...doctors.map((doctor) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: RecommendedDoctorCard(doctor: doctor),
          );
        }),
      ],
    );
  }
}
