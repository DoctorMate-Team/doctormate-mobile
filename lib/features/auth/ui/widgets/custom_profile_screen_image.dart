import 'dart:io';

import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/features/auth/ui/widgets/profile_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomProfileScreenImage extends StatelessWidget {
  const CustomProfileScreenImage({
    super.key,
    required this.onTap,
    this.isEdit = false,
    this.imageUrl,
    this.imageFile,
  });
  final Function() onTap;
  final bool isEdit;
  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ProfileNetworkImage(imageUrl: imageUrl, imageFile: imageFile),
        if (isEdit)
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: onTap,
              child: CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.white,
                child: Icon(
                  Iconsax.edit_copy,
                  size: 16.r,
                  color: ColorsManager.primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
