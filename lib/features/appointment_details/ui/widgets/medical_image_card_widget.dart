import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class MedicalImageCardWidget extends StatelessWidget {
  final String imageUrl;
  final String imageType;
  final String? description;
  final DateTime uploadedAt;

  const MedicalImageCardWidget({
    super.key,
    required this.imageUrl,
    required this.imageType,
    this.description,
    required this.uploadedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Icon(
                      Iconsax.gallery_slash,
                      size: 32.sp,
                      color: Colors.grey[400],
                    ),
                  ),
            ),
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: _getImageTypeColor(imageType),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                imageType,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (description != null)
                    Text(
                      description!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeightHelper.medium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    DateFormat('MMM dd, yyyy').format(uploadedAt),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getImageTypeColor(String type) {
    switch (type.toUpperCase()) {
      case 'DICOM':
        return Colors.purple;
      case 'JPG':
      case 'JPEG':
        return Colors.blue;
      case 'PNG':
        return Colors.green;
      case 'X-RAY':
        return Colors.indigo;
      case 'MRI':
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }
}
