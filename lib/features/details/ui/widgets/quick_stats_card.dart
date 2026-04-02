import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class QuickStatsCard extends StatelessWidget {
  const QuickStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.primaryColor.withOpacity(0.05),
            ColorsManager.primaryColor.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorsManager.primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Iconsax.people,
            value: '2,000+',
            label: 'Patients',
            color: ColorsManager.primaryColor,
          ),
          _Divider(),
          _StatItem(
            icon: Iconsax.medal_star,
            value: '10+',
            label: 'Experience',
            color: Colors.orange,
          ),
          _Divider(),
          _StatItem(
            icon: Iconsax.star_1,
            value: '4.8',
            label: 'Rating',
            color: ColorsManager.gold,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24.sp),
        ),
        verticalSpacing(8),
        Text(
          value,
          style: TextStyles.font16DarkGreenBold.copyWith(
            fontWeight: FontWeightHelper.bold,
            fontSize: 18.sp,
          ),
        ),
        verticalSpacing(2),
        Text(label, style: TextStyles.font12GrayRegular),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 50.h, width: 1, color: Colors.grey.shade300);
  }
}
