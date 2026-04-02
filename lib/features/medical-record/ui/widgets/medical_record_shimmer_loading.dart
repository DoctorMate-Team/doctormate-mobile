import 'package:doctor_mate/core/widgets/custom_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalRecordShimmerLoading extends StatelessWidget {
  const MedicalRecordShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
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
              // Header shimmer
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Row(
                  children: [
                    CustomShimmerLoading(
                      width: 40.w,
                      height: 40.w,
                      borderRadius: 8.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmerLoading(
                            width: 120.w,
                            height: 14.h,
                            borderRadius: 4.r,
                          ),
                          SizedBox(height: 6.h),
                          CustomShimmerLoading(
                            width: 80.w,
                            height: 12.h,
                            borderRadius: 4.r,
                          ),
                        ],
                      ),
                    ),
                    CustomShimmerLoading(
                      width: 70.w,
                      height: 24.h,
                      borderRadius: 12.r,
                    ),
                  ],
                ),
              ),

              // Content shimmer
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerLoading(
                      width: double.infinity,
                      height: 18.h,
                      borderRadius: 4.r,
                    ),
                    SizedBox(height: 8.h),
                    CustomShimmerLoading(
                      width: double.infinity,
                      height: 14.h,
                      borderRadius: 4.r,
                    ),
                    SizedBox(height: 6.h),
                    CustomShimmerLoading(
                      width: 200.w,
                      height: 14.h,
                      borderRadius: 4.r,
                    ),
                    SizedBox(height: 12.h),
                    CustomShimmerLoading(
                      width: 150.w,
                      height: 14.h,
                      borderRadius: 4.r,
                    ),
                    SizedBox(height: 8.h),
                    CustomShimmerLoading(
                      width: 180.w,
                      height: 12.h,
                      borderRadius: 4.r,
                    ),
                    SizedBox(height: 8.h),
                    CustomShimmerLoading(
                      width: 140.w,
                      height: 12.h,
                      borderRadius: 4.r,
                    ),
                  ],
                ),
              ),

              // Actions shimmer
              Divider(height: 1, color: Colors.grey.shade200),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomShimmerLoading(
                      width: 100.w,
                      height: 32.h,
                      borderRadius: 8.r,
                    ),
                    SizedBox(width: 12.w),
                    CustomShimmerLoading(
                      width: 80.w,
                      height: 32.h,
                      borderRadius: 8.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
