import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.search_normal,
              size: 50.sp,
              color: Colors.grey.shade400,
            ),
          ),
          verticalSpacing(24),
          Text('No doctors found', style: TextStyles.font18DarkGreenBold),
          verticalSpacing(8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              'Try adjusting your search or filters to find what you\'re looking for',
              style: TextStyles.font14GrayRegular,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
