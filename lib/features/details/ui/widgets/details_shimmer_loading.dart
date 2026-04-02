import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsShimmerLoading extends StatelessWidget {
  const DetailsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          verticalSpacing(16),

          // Doctor Header Shimmer
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Doctor Image Shimmer
                    CustomShimmerLoading(
                      height: 90,
                      width: 90,
                      borderRadius: 20,
                    ),

                    horizantialSpacing(16),

                    // Doctor Info Shimmer
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmerLoading(
                            height: 20,
                            width: 150,
                            borderRadius: 8,
                          ),
                          verticalSpacing(8),
                          CustomShimmerLoading(
                            height: 24,
                            width: 100,
                            borderRadius: 8,
                          ),
                          verticalSpacing(10),
                          CustomShimmerLoading(
                            height: 16,
                            width: 120,
                            borderRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                verticalSpacing(16),

                const Divider(),

                verticalSpacing(16),

                // Action Buttons Shimmer
                Row(
                  children: [
                    Expanded(
                      child: CustomShimmerLoading(
                        height: 60,
                        width: double.infinity,
                        borderRadius: 12,
                      ),
                    ),
                    horizantialSpacing(12),
                    Expanded(
                      child: CustomShimmerLoading(
                        height: 60,
                        width: double.infinity,
                        borderRadius: 12,
                      ),
                    ),
                    horizantialSpacing(12),
                    Expanded(
                      child: CustomShimmerLoading(
                        height: 60,
                        width: double.infinity,
                        borderRadius: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          verticalSpacing(16),

          // Quick Stats Shimmer
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const _StatShimmer(),
                Container(height: 50.h, width: 1, color: Colors.grey.shade300),
                const _StatShimmer(),
                Container(height: 50.h, width: 1, color: Colors.grey.shade300),
                const _StatShimmer(),
              ],
            ),
          ),

          verticalSpacing(24),

          // Tab Bar Section Shimmer
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                // Tab Bar Shimmer
                Container(
                  padding: EdgeInsets.all(20.w),
                  child: CustomShimmerLoading(
                    height: 50,
                    width: double.infinity,
                    borderRadius: 12,
                  ),
                ),

                // Content Shimmer
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimmerLoading(
                        height: 20,
                        width: 120,
                        borderRadius: 8,
                      ),
                      verticalSpacing(12),
                      CustomShimmerLoading(
                        height: 60,
                        width: double.infinity,
                        borderRadius: 8,
                      ),
                      verticalSpacing(24),
                      CustomShimmerLoading(
                        height: 80,
                        width: double.infinity,
                        borderRadius: 12,
                      ),
                      verticalSpacing(12),
                      CustomShimmerLoading(
                        height: 80,
                        width: double.infinity,
                        borderRadius: 12,
                      ),
                      verticalSpacing(12),
                      CustomShimmerLoading(
                        height: 80,
                        width: double.infinity,
                        borderRadius: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          verticalSpacing(100),
        ],
      ),
    );
  }
}

class _StatShimmer extends StatelessWidget {
  const _StatShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomShimmerLoading(height: 48, width: 48, borderRadius: 24),
        verticalSpacing(8),
        CustomShimmerLoading(height: 20, width: 50, borderRadius: 8),
        verticalSpacing(4),
        CustomShimmerLoading(height: 14, width: 60, borderRadius: 8),
      ],
    );
  }
}
