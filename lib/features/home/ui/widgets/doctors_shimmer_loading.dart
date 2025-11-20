import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsShimmerLoading extends StatelessWidget {
  const DoctorsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: const _DoctorShimmerItem(),
        ),
      ),
    );
  }
}

class _DoctorShimmerItem extends StatelessWidget {
  const _DoctorShimmerItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Doctor Image placeholder
              CustomShimmerLoading(
                width: 70.w,
                height: 70.h,
                borderRadius: 12.r,
              ),
              horizantialSpacing(16),
              // Doctor Info placeholder
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name placeholder
                    CustomShimmerLoading(
                      width: 140.w,
                      height: 16.h,
                      borderRadius: 8.r,
                    ),
                    verticalSpacing(4),
                    // Address placeholder
                    CustomShimmerLoading(
                      width: 100.w,
                      height: 14.h,
                      borderRadius: 7.r,
                    ),
                    verticalSpacing(8),
                    // Qualification placeholder
                    CustomShimmerLoading(
                      width: 120.w,
                      height: 14.h,
                      borderRadius: 7.r,
                    ),
                  ],
                ),
              ),
              // Price placeholder
              Column(
                children: [
                  CustomShimmerLoading(
                    width: 50.w,
                    height: 16.h,
                    borderRadius: 8.r,
                  ),
                  verticalSpacing(4),
                  CustomShimmerLoading(
                    width: 50.w,
                    height: 12.h,
                    borderRadius: 6.r,
                  ),
                ],
              ),
            ],
          ),
          verticalSpacing(16),
          // Bottom row placeholder
          Row(
            children: [
              Expanded(
                child: CustomShimmerLoading(
                  width: double.infinity,
                  height: 28.h,
                  borderRadius: 8.r,
                ),
              ),
              horizantialSpacing(16),
              CustomShimmerLoading(
                width: 100.w,
                height: 36.h,
                borderRadius: 8.r,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
