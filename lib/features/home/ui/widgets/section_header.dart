import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;
  
  const SectionHeader({
    super.key,
    required this.title,
    required this.actionText, this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.font16DarkGreenBold.copyWith(
            fontWeight: FontWeightHelper.semiBold,
            color: Colors.grey.shade800,
          ),
        ),
        TextButton(
          onPressed: onActionTap,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            actionText,
            style: TextStyles.font14DarkGreenMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
