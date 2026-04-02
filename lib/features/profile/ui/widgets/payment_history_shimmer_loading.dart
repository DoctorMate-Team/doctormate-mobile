import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PaymentHistoryShimmerLoading extends StatelessWidget {
  const PaymentHistoryShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 100.w, height: 16.h, color: Colors.white),
                    Container(width: 60.w, height: 16.h, color: Colors.white),
                  ],
                ),
                verticalSpacing(12),
                Container(width: 150.w, height: 14.h, color: Colors.white),
                verticalSpacing(8),
                Container(width: 120.w, height: 14.h, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
