import 'package:doctor_mate/core/helper/app_images.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, this.isBack = false});
  final bool? isBack;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Stack(
            children: [
              // Back button positioned on the left
              if (isBack == true)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              // Logo and text centered
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppImages.logoWhite),
                    horizantialSpacing(5),
                    Text("DoctorMate", style: TextStyles.font24WhiteBold),
                  ],
                ),
              ),
            ],
          ),
        ),
        verticalSpacing(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            assetImage(AppImages.auth1),
            assetImage(AppImages.auth2),
            assetImage(AppImages.auth3),
          ],
        ),
      ],
    );
  }
}

Image assetImage(String image) =>
    Image.asset(image, fit: BoxFit.contain, height: 115.h, width: 115.w);
