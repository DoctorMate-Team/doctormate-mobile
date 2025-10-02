import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SafeCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const SafeCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: ColorsManager.lightGray,
          child: const Center(
            child: CircularProgressIndicator(
              color: ColorsManager.primaryColor,
              strokeWidth: 2.0,
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          // Log the error for debugging
          debugPrint('Image loading error for URL: $url');
          debugPrint('Error: $error');

          return Container(
            width: width,
            height: height,
            color: ColorsManager.lightGray,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_not_supported_outlined,
                  color: ColorsManager.lightGreen,
                  size: 24.w,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Image not available',
                  style: TextStyle(
                    color: ColorsManager.lightGreen,
                    fontSize: 10.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
