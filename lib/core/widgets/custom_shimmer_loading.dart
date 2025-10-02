import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerLoading extends StatelessWidget {
  const CustomShimmerLoading({
    super.key, required this.height, required this.width, required this.borderRadius,
  });
  final double height;
  final double width;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsManager.lightGray,
      highlightColor: ColorsManager.lightGray.withOpacity(0.5),
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: ColorsManager.lightGray,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}