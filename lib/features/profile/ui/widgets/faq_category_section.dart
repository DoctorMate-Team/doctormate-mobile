import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}

class FaqCategorySection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<FaqItem> items;

  const FaqCategorySection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: ColorsManager.primaryColor, size: 20.sp),
            horizantialSpacing(8),
            Text(title, style: TextStyles.font14GreenSemiBold),
          ],
        ),
        verticalSpacing(12),
        ...items.map((item) => _FaqTile(item: item)),
      ],
    );
  }
}

class _FaqTile extends StatelessWidget {
  final FaqItem item;

  const _FaqTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
        childrenPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        title: Text(item.question, style: TextStyles.font14GreenSemiBold),
        children: [Text(item.answer, style: TextStyles.font14GrayRegular)],
      ),
    );
  }
}
