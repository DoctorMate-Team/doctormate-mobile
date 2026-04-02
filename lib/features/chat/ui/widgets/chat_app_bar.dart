import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatAppBar extends StatelessWidget {
  final ChatConversationResponse conversation;
  final VoidCallback onCallTap;

  const ChatAppBar({
    super.key,
    required this.conversation,
    required this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ColorsManager.primaryColor,
                size: 18.sp,
              ),
            ),
          ),
          horizantialSpacing(12),
          _buildDoctorInfo(),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Expanded(
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorsManager.primaryColor.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child:
                      conversation.doctorImage != null
                          ? CachedNetworkImage(
                            imageUrl: conversation.doctorImage!,
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => Container(
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Iconsax.user,
                                    color: Colors.grey.shade400,
                                    size: 22.sp,
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Container(
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Iconsax.user,
                                    color: Colors.grey.shade400,
                                    size: 22.sp,
                                  ),
                                ),
                          )
                          : Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Iconsax.user,
                              color: Colors.grey.shade400,
                              size: 22.sp,
                            ),
                          ),
                ),
              ),
              if (conversation.isOnline ?? false)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          horizantialSpacing(10),
          Text(
            conversation.doctorName ?? 'Doctor',
            style: TextStyles.font16DarkGreenBold,
          ),
        ],
      ),
    );
  }
}
