import 'dart:io';

import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ImageUploadCard extends StatelessWidget {
  final String? uploadedImagePath;
  final Function(String?) onImagePicked;

  const ImageUploadCard({
    super.key,
    required this.uploadedImagePath,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload Skin Image', style: TextStyles.font16DarkGreenBold),
        verticalSpacing(12),
        GestureDetector(
          onTap: () => _handleImagePick(context),
          child: Container(
            width: double.infinity,
            height: 280.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child:
                uploadedImagePath == null
                    ? _buildUploadPlaceholder()
                    : _buildUploadedImage(),
          ),
        ),
        verticalSpacing(12),
        _buildImageGuidelines(),
      ],
    );
  }

  Widget _buildUploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9C27B0).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Iconsax.gallery_add, color: Colors.white, size: 36.sp),
        ),
        verticalSpacing(16),
        Text('Tap to Upload Image', style: TextStyles.font16DarkGreenBold),
        verticalSpacing(8),
        Text(
          'Take a clear photo or select from gallery',
          style: TextStyles.font14DarkGreenMedium.copyWith(
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        verticalSpacing(16),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: ColorsManager.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Iconsax.camera,
                color: ColorsManager.primaryColor,
                size: 16.sp,
              ),
              horizantialSpacing(6),
              Text(
                'Camera',
                style: TextStyles.font12DarkGreenSemiBold.copyWith(
                  color: ColorsManager.primaryColor,
                ),
              ),
              horizantialSpacing(12),
              Container(width: 1, height: 16.h, color: Colors.grey.shade300),
              horizantialSpacing(12),
              Icon(
                Iconsax.gallery,
                color: ColorsManager.primaryColor,
                size: 16.sp,
              ),
              horizantialSpacing(6),
              Text(
                'Gallery',
                style: TextStyles.font12DarkGreenSemiBold.copyWith(
                  color: ColorsManager.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadedImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.file(
            File(uploadedImagePath!),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 12.h,
          right: 12.w,
          child: GestureDetector(
            onTap: () => onImagePicked(null),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Iconsax.trash, color: Colors.white, size: 20.sp),
            ),
          ),
        ),
        Positioned(
          bottom: 12.h,
          left: 12.w,
          right: 12.w,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.tick_circle,
                  color: Colors.green.shade400,
                  size: 20.sp,
                ),
                horizantialSpacing(8),
                Expanded(
                  child: Text(
                    'Image uploaded successfully',
                    style: TextStyles.font12DarkGreenRegular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGuidelines() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.info_circle, color: Colors.blue.shade700, size: 18.sp),
          horizantialSpacing(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tips for Better Results',
                  style: TextStyles.font14GreenSemiBold.copyWith(
                    color: Colors.blue.shade900,
                  ),
                ),
                verticalSpacing(4),
                Text(
                  '• Use good lighting\n• Focus on the affected area\n• Avoid blur or shadows\n• Take from a close distance',
                  style: TextStyles.font12DarkGreenRegular.copyWith(
                    color: Colors.blue.shade800,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleImagePick(BuildContext context) {
    // TODO: Implement actual image picker
    // For now, simulate image selection with a mock path
    onImagePicked('/mock/path/to/image.jpg');
  }
}
