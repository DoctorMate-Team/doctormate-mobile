import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentDetailsShimmerLoading extends StatelessWidget {
  const AppointmentDetailsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Appointment info card shimmer
        _buildCardShimmer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomShimmerLoading(
                    height: 60,
                    width: 60,
                    borderRadius: 12,
                  ),
                  horizantialSpacing(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomShimmerLoading(
                          height: 16,
                          width: 150,
                          borderRadius: 8,
                        ),
                        verticalSpacing(8),
                        const CustomShimmerLoading(
                          height: 14,
                          width: 100,
                          borderRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpacing(12),
              const CustomShimmerLoading(
                height: 12,
                width: double.infinity,
                borderRadius: 8,
              ),
              verticalSpacing(8),
              const CustomShimmerLoading(
                height: 12,
                width: 200,
                borderRadius: 8,
              ),
            ],
          ),
        ),
        verticalSpacing(16),

        // Communication buttons shimmer
        _buildCardShimmer(
          child: Row(
            children: [
              const Expanded(
                child: CustomShimmerLoading(
                  height: 48,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ),
              horizantialSpacing(12),
              const Expanded(
                child: CustomShimmerLoading(
                  height: 48,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ),
              horizantialSpacing(12),
              const Expanded(
                child: CustomShimmerLoading(
                  height: 48,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ),
            ],
          ),
        ),
        verticalSpacing(16),

        // Section cards shimmer (4 cards)
        for (int i = 0; i < 4; i++) ...[
          _buildSectionCardShimmer(),
          verticalSpacing(16),
        ],
      ],
    );
  }

  Widget _buildCardShimmer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSectionCardShimmer() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CustomShimmerLoading(
                height: 40,
                width: 40,
                borderRadius: 12,
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomShimmerLoading(
                      height: 16,
                      width: 120,
                      borderRadius: 8,
                    ),
                    verticalSpacing(6),
                    const CustomShimmerLoading(
                      height: 12,
                      width: 180,
                      borderRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          const CustomShimmerLoading(
            height: 14,
            width: double.infinity,
            borderRadius: 8,
          ),
          verticalSpacing(8),
          const CustomShimmerLoading(
            height: 14,
            width: double.infinity,
            borderRadius: 8,
          ),
          verticalSpacing(8),
          const CustomShimmerLoading(height: 14, width: 150, borderRadius: 8),
        ],
      ),
    );
  }
}
