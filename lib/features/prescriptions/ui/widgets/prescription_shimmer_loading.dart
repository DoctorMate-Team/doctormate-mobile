import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrescriptionShimmerLoading extends StatelessWidget {
  const PrescriptionShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header card shimmer
          CustomShimmerLoading(
            height: 150,
            width: double.infinity,
            borderRadius: 16,
          ),
          verticalSpacing(16),
          // Patient card shimmer
          CustomShimmerLoading(
            height: 100,
            width: double.infinity,
            borderRadius: 16,
          ),
          verticalSpacing(16),
          // Doctor card shimmer
          CustomShimmerLoading(
            height: 100,
            width: double.infinity,
            borderRadius: 16,
          ),
          verticalSpacing(16),
          // Medications card shimmer
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomShimmerLoading(height: 20, width: 150, borderRadius: 8),
                verticalSpacing(16),
                CustomShimmerLoading(
                  height: 120,
                  width: double.infinity,
                  borderRadius: 12,
                ),
                verticalSpacing(12),
                CustomShimmerLoading(
                  height: 120,
                  width: double.infinity,
                  borderRadius: 12,
                ),
                verticalSpacing(12),
                CustomShimmerLoading(
                  height: 120,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ],
            ),
          ),
          verticalSpacing(16),
          // Validity card shimmer
          CustomShimmerLoading(
            height: 80,
            width: double.infinity,
            borderRadius: 16,
          ),
          verticalSpacing(24),
          // Action buttons shimmer
          Row(
            children: [
              Expanded(
                child: CustomShimmerLoading(
                  height: 48,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: CustomShimmerLoading(
                  height: 48,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ),
            ],
          ),
          verticalSpacing(12),
          CustomShimmerLoading(
            height: 48,
            width: double.infinity,
            borderRadius: 12,
          ),
          verticalSpacing(16),
        ],
      ),
    );
  }
}
