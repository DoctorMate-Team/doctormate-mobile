import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                // TODO: Attach file
              },
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.paperclip,
                  color: Colors.grey.shade600,
                  size: 20.sp,
                ),
              ),
            ),
            horizantialSpacing(12),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        style: TextStyles.font14DarkGreenMedium,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyles.font14DarkGreenMedium.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Emoji picker
                      },
                      child: Icon(
                        Iconsax.emoji_happy,
                        color: Colors.grey.shade600,
                        size: 22.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            horizantialSpacing(12),
            GestureDetector(
              onTap: _hasText ? widget.onSend : null,
              child: Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  gradient:
                      _hasText
                          ? const LinearGradient(
                            colors: [Color(0xFF34A853), Color(0xFF2E7D32)],
                          )
                          : null,
                  color: _hasText ? null : Colors.grey.shade300,
                  shape: BoxShape.circle,
                  boxShadow:
                      _hasText
                          ? [
                            BoxShadow(
                              color: const Color(0xFF34A853).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                          : null,
                ),
                child: Icon(
                  Iconsax.send_1,
                  color: _hasText ? Colors.white : Colors.grey.shade500,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
