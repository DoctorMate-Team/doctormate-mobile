import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ModernSpecialistsList extends StatelessWidget {
  final String selectedSpecialist;
  final Function(String) onSpecialistTap;

  const ModernSpecialistsList({
    super.key,
    required this.selectedSpecialist,
    required this.onSpecialistTap,
  });

  List<Map<String, dynamic>> get _specialists => [
    {
      'name': 'Cardiology',
      'icon': Iconsax.heart,
      'color': Colors.red,
      'bgColor': const Color(0xFFFFEBEE),
    },
    {
      'name': 'Neurology',
      'icon': Iconsax.cpu,
      'color': Colors.purple,
      'bgColor': const Color(0xFFF3E5F5),
    },
    {
      'name': 'Orthopedic',
      'icon': Iconsax.user_tag,
      'color': Colors.orange,
      'bgColor': const Color(0xFFFFF3E0),
    },
    {
      'name': 'Pediatrics',
      'icon': Iconsax.profile_2user,
      'color': Colors.pink,
      'bgColor': const Color(0xFFFCE4EC),
    },
    {
      'name': 'Dermatology',
      'icon': Iconsax.sun_1,
      'color': Colors.amber,
      'bgColor': const Color(0xFFFFFDE7),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemBuilder: (context, index) {
          final specialist = _specialists[index];
          final isSelected = selectedSpecialist == specialist['name'];

          return Container(
            width: 100.w,
            decoration: BoxDecoration(
              color: isSelected ? ColorsManager.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color:
                      isSelected
                          ? ColorsManager.primaryColor.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.1),
                  blurRadius: isSelected ? 12 : 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () => onSpecialistTap(specialist['name']),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : specialist['bgColor'],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          specialist['icon'],
                          color:
                              isSelected ? Colors.white : specialist['color'],
                          size: 24.sp,
                        ),
                      ),
                      verticalSpacing(12),
                      Text(
                        specialist['name'],
                        style: TextStyles.font12DarkGreenSemiBold.copyWith(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade800,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => horizantialSpacing(12),
        itemCount: _specialists.length,
      ),
    );
  }
}
