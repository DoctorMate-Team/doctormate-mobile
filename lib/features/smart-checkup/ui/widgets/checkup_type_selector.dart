import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CheckupTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const CheckupTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Check Type', style: TextStyles.font16DarkGreenBold),
        verticalSpacing(12),
        Row(
          children: [
            Expanded(
              child: _buildTypeCard(
                type: 'symptom',
                title: 'Symptom Check',
                subtitle: 'Describe your symptoms',
                icon: Iconsax.health,
                gradient: const [Color(0xFF4285F4), Color(0xFF1976D2)],
              ),
            ),
            horizantialSpacing(12),
            Expanded(
              child: _buildTypeCard(
                type: 'skin',
                title: 'Skin Analysis',
                subtitle: 'Upload skin image',
                icon: Iconsax.camera,
                gradient: const [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeCard({
    required String type,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
  }) {
    final isSelected = selectedType == type;

    return GestureDetector(
      onTap: () => onTypeChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient:
              isSelected
                  ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradient,
                  )
                  : null,
          color: isSelected ? null : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: gradient[0].withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Column(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.white.withOpacity(0.2)
                        : ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color:
                      isSelected
                          ? Colors.white.withOpacity(0.3)
                          : ColorsManager.primaryColor.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : ColorsManager.primaryColor,
                size: 24.sp,
              ),
            ),
            verticalSpacing(12),
            Text(
              title,
              style: TextStyles.font14GreenSemiBold.copyWith(
                color: isSelected ? Colors.white : Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(4),
            Text(
              subtitle,
              style: TextStyles.font12DarkGreenRegular.copyWith(
                color:
                    isSelected
                        ? Colors.white.withOpacity(0.9)
                        : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
