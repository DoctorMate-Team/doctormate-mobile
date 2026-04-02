import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialistsShimmerLoading extends StatelessWidget {
  const SpecialistsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: 5,
        separatorBuilder: (context, index) => horizantialSpacing(12),
        itemBuilder: (context, index) {
          return const _SpecialistShimmerItem();
        },
      ),
    );
  }
}

class _SpecialistShimmerItem extends StatelessWidget {
  const _SpecialistShimmerItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon placeholder
            CustomShimmerLoading(width: 44.w, height: 44.h, borderRadius: 12.r),
            verticalSpacing(8),
            // Text placeholder
            CustomShimmerLoading(width: 70.w, height: 11.h, borderRadius: 6.r),
          ],
        ),
      ),
    );
  }
}
