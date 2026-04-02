import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/home/data/models/specialty_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ModernSpecialistsList extends StatelessWidget {
  final List<SpecialtyModel> specialties;
  final String? selectedSpecialtyId;
  final Function(String) onSpecialistTap;

  const ModernSpecialistsList({
    super.key,
    required this.specialties,
    required this.selectedSpecialtyId,
    required this.onSpecialistTap,
  });

  IconData _getIconForSpecialty(String name) {
    final nameLower = name.toLowerCase();
    if (nameLower.contains('cardio')) return Iconsax.heart;
    if (nameLower.contains('neuro')) return Iconsax.cpu;
    if (nameLower.contains('ortho')) return Iconsax.user_tag;
    if (nameLower.contains('pediatric') || nameLower.contains('child')) {
      return Iconsax.profile_2user;
    }
    if (nameLower.contains('derma') || nameLower.contains('skin')) {
      return Iconsax.sun_1;
    }
    return Iconsax.hospital;
  }

  Color _getColorForIndex(int index) {
    final colors = [
      Colors.red,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.amber,
      Colors.blue,
      Colors.teal,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }

  Color _getBgColorForIndex(int index) {
    final bgColors = [
      const Color(0xFFFFEBEE),
      const Color(0xFFF3E5F5),
      const Color(0xFFFFF3E0),
      const Color(0xFFFCE4EC),
      const Color(0xFFFFFDE7),
      const Color(0xFFE3F2FD),
      const Color(0xFFE0F2F1),
      const Color(0xFFE8EAF6),
    ];
    return bgColors[index % bgColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          final isSelected = selectedSpecialtyId == specialty.id;

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
                onTap: () => onSpecialistTap(specialty.id),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : _getBgColorForIndex(index),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child:
                            specialty.imageUrl.isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: CachedNetworkImage(
                                    imageUrl: specialty.imageUrl,
                                    width: 48.w,
                                    height: 48.h,
                                    fit: BoxFit.cover,
                                    color:
                                        isSelected
                                            ? Colors.white.withOpacity(0.9)
                                            : null,
                                    colorBlendMode:
                                        isSelected ? BlendMode.modulate : null,
                                    placeholder:
                                        (context, url) => Icon(
                                          _getIconForSpecialty(specialty.name),
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : _getColorForIndex(index),
                                          size: 24.sp,
                                        ),
                                    errorWidget:
                                        (context, url, error) => Icon(
                                          _getIconForSpecialty(specialty.name),
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : _getColorForIndex(index),
                                          size: 24.sp,
                                        ),
                                  ),
                                )
                                : Icon(
                                  _getIconForSpecialty(specialty.name),
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : _getColorForIndex(index),
                                  size: 24.sp,
                                ),
                      ),
                      verticalSpacing(8),
                      Text(
                        specialty.name,
                        style: TextStyles.font12DarkGreenSemiBold.copyWith(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade800,
                          fontSize: 11.sp,
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
        itemCount: specialties.length,
      ),
    );
  }
}
