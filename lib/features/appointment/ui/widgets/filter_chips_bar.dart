import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipsBar extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const FilterChipsBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Today', 'This Week', 'This Month'];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              filters.map((filter) {
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) => onFilterChanged(filter),
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: ColorsManager.lighterMainBlue,
                    labelStyle: TextStyles.font12GrayRegular.copyWith(
                      color:
                          isSelected
                              ? ColorsManager.primaryColor
                              : ColorsManager.gray,
                      fontWeight:
                          isSelected
                              ? FontWeightHelper.semiBold
                              : FontWeight.normal,
                    ),
                    checkmarkColor: ColorsManager.primaryColor,
                    side: BorderSide(
                      color:
                          isSelected
                              ? ColorsManager.primaryColor
                              : Colors.transparent,
                      width: 1,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
