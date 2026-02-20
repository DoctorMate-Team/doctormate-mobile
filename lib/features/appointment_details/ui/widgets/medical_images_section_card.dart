import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/features/appointment/data/models/appointment_list_response.dart';
import 'package:doctor_mate/features/appointment_details/data/models/appointment_details_response.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/section_header_widget.dart';
import 'package:doctor_mate/features/appointment_details/ui/widgets/section_empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class MedicalImagesSectionCard extends StatelessWidget {
  final PatientAppointmentModel appointment;
  final List<MedicalImage> medicalImages;

  const MedicalImagesSectionCard({
    super.key,
    required this.appointment,
    this.medicalImages = const [],
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImages = medicalImages.isNotEmpty;

    return Container(
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
        children: [
          const SectionHeaderWidget(
            icon: Iconsax.gallery,
            iconColor: Colors.purple,
            title: 'Medical Images',
            subtitle: 'DICOM, X-Ray, MRI & other images',
          ),
          Divider(height: 1, color: Colors.grey[200]),
          if (hasImages)
            _buildImagesGrid(medicalImages)
          else
            const SectionEmptyStateWidget(
              icon: Iconsax.gallery,
              title: 'No Medical Images',
              message: 'Medical images will appear here once uploaded',
            ),
        ],
      ),
    );
  }

  Widget _buildImagesGrid(List<MedicalImage> images) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 1,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return _buildImageCard(
            imageUrl: image.viewerUrl,
            imageType: image.fileType,
            description: image.description,
            uploadedAt: image.createdAt,
            isCritical: image.isCritical,
          );
        },
      ),
    );
  }

  Widget _buildImageCard({
    required String imageUrl,
    required String imageType,
    String? description,
    required DateTime uploadedAt,
    required bool isCritical,
  }) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
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
                if (isCritical) ...[
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'CRITICAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp,
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                  ),
                ],
              ],
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
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
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
                      description,
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
                    style: TextStyle(color: Colors.white70, fontSize: 10.sp),
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
