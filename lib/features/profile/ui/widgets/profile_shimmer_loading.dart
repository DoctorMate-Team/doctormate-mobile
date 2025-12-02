import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image and Info
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                // Profile Image
                CustomShimmerLoading(
                  width: 100.w,
                  height: 100.h,
                  borderRadius: 50.r,
                ),
                verticalSpacing(12),
                // Name
                CustomShimmerLoading(
                  width: 150.w,
                  height: 16.h,
                  borderRadius: 8.r,
                ),
                verticalSpacing(4),
                // Email
                CustomShimmerLoading(
                  width: 180.w,
                  height: 14.h,
                  borderRadius: 7.r,
                ),
              ],
            ),
          ),
          verticalSpacing(20),

          // Account Settings Section
          CustomShimmerLoading(width: 140.w, height: 16.h, borderRadius: 8.r),
          verticalSpacing(12),
          const _ActionButtonShimmer(),
          verticalSpacing(12),
          const _ActionButtonShimmer(),
          verticalSpacing(12),
          const _ActionButtonShimmer(),
          verticalSpacing(12),
          const _ActionButtonShimmer(),

          verticalSpacing(20),

          // Help & Support Section
          CustomShimmerLoading(width: 140.w, height: 16.h, borderRadius: 8.r),
          verticalSpacing(12),
          const _ActionButtonShimmer(),
          verticalSpacing(12),
          const _ActionButtonShimmer(),
          verticalSpacing(12),
          const _ActionButtonShimmer(),
          verticalSpacing(12),
          const _ActionButtonShimmer(),
        ],
      ),
    );
  }
}

class _ActionButtonShimmer extends StatelessWidget {
  const _ActionButtonShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomShimmerLoading(width: 24.w, height: 24.h, borderRadius: 6.r),
          horizantialSpacing(12),
          CustomShimmerLoading(width: 120.w, height: 14.h, borderRadius: 7.r),
        ],
      ),
    );
  }
}
