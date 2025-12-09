import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentShimmerLoading extends StatelessWidget {
  const AppointmentShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status header
              Row(
                children: [
                  CustomShimmerLoading(height: 18, width: 18, borderRadius: 4),
                  horizantialSpacing(8),
                  CustomShimmerLoading(height: 14, width: 80, borderRadius: 4),
                  const Spacer(),
                  CustomShimmerLoading(height: 12, width: 100, borderRadius: 4),
                ],
              ),
              verticalSpacing(16),
              // Doctor info
              Row(
                children: [
                  CustomShimmerLoading(height: 60, width: 60, borderRadius: 12),
                  horizantialSpacing(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmerLoading(
                          height: 16,
                          width: double.infinity,
                          borderRadius: 4,
                        ),
                        verticalSpacing(8),
                        CustomShimmerLoading(
                          height: 12,
                          width: 150,
                          borderRadius: 4,
                        ),
                        verticalSpacing(6),
                        CustomShimmerLoading(
                          height: 12,
                          width: 120,
                          borderRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpacing(16),
              // Date and time section
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CustomShimmerLoading(
                            height: 20,
                            width: 20,
                            borderRadius: 4,
                          ),
                          verticalSpacing(8),
                          CustomShimmerLoading(
                            height: 12,
                            width: 60,
                            borderRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40.h,
                      color: Colors.grey.shade300,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CustomShimmerLoading(
                            height: 20,
                            width: 20,
                            borderRadius: 4,
                          ),
                          verticalSpacing(8),
                          CustomShimmerLoading(
                            height: 12,
                            width: 60,
                            borderRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpacing(16),
              // Action buttons
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
            ],
          ),
        );
      },
    );
  }
}
