import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileNetworkImage extends StatelessWidget {
  const ProfileNetworkImage({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60.r,
      backgroundColor: ColorsManager.lighterMainBlue,
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? "",
        imageBuilder:
            (context, imageProvider) => Container(
              margin: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor,
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
        placeholder:
            (context, url) => const CircularProgressIndicator(
              color: ColorsManager.primaryColor,
            ),
        errorWidget:
            (context, url, error) => Icon(
              Icons.person,
              size: 60.sp,
              color: ColorsManager.primaryColor,
            ),
      ),
    );
  }
}