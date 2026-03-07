import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/reviews/data/models/create_review_request.dart';
import 'package:doctor_mate/features/reviews/data/models/review_model.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_cubit.dart';
import 'package:doctor_mate/features/reviews/logic/cubit/reviews_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AddReviewDialog extends StatefulWidget {
  final String appointmentId;
  final ReviewModel? existingReview;

  const AddReviewDialog({
    super.key,
    required this.appointmentId,
    this.existingReview,
  });

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  final _commentController = TextEditingController();
  int _rating = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingReview != null) {
      _rating = widget.existingReview!.rating;
      _commentController.text = widget.existingReview!.comment;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewsCubit, ReviewsState>(
      listenWhen:
          (previous, current) => current.maybeWhen(
            orElse: () => false,
            createReviewLoading: () => true,
            createReviewSuccess: (_) => true,
            createReviewError: (_) => true,
            updateReviewLoading: () => true,
            updateReviewSuccess: (_) => true,
            updateReviewError: (_) => true,
          ),
      listener: (context, state) {
        state.whenOrNull(
          createReviewLoading: () {
            setState(() => _isLoading = true);
          },
          createReviewSuccess: (review) {
            setState(() => _isLoading = false);
            Navigator.of(context).pop(true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Review submitted successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
          createReviewError: (error) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error), backgroundColor: Colors.red),
            );
          },
          updateReviewLoading: () {
            setState(() => _isLoading = true);
          },
          updateReviewSuccess: (review) {
            setState(() => _isLoading = false);
            Navigator.of(context).pop(true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Review updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
          updateReviewError: (error) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error), backgroundColor: Colors.red),
            );
          },
        );
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.existingReview != null
                        ? 'Update Review'
                        : 'Rate Your Experience',
                    style: TextStyles.font18DarkGreenBold.copyWith(
                      fontWeight: FontWeightHelper.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              verticalSpacing(16),
              Text(
                'Rating',
                style: TextStyles.font14DarkGreenMedium.copyWith(
                  fontWeight: FontWeightHelper.semiBold,
                ),
              ),
              verticalSpacing(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Icon(
                        index < _rating ? Iconsax.star_1 : Iconsax.star,
                        color:
                            index < _rating
                                ? ColorsManager.gold
                                : Colors.grey[300],
                        size: 40.sp,
                      ),
                    ),
                  );
                }),
              ),
              verticalSpacing(20),
              Text(
                'Your Review',
                style: TextStyles.font14DarkGreenMedium.copyWith(
                  fontWeight: FontWeightHelper.semiBold,
                ),
              ),
              verticalSpacing(8),
              TextField(
                controller: _commentController,
                maxLines: 5,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: 'Share your experience...',
                  hintStyle: TextStyles.font14GrayRegular,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: ColorsManager.primaryColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
              verticalSpacing(24),
              Row(
                children: [
                  Expanded(
                    child: CustomMaterialButton(
                      textButton: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.grey.shade200,
                      textColor: ColorsManager.darkBlue,
                    ),
                  ),
                  horizantialSpacing(12),
                  Expanded(
                    child: CustomMaterialButton(
                      textButton:
                          _isLoading
                              ? 'Submitting...'
                              : (widget.existingReview != null
                                  ? 'Update'
                                  : 'Submit'),
                      onPressed: _isLoading ? () {} : _submitReview,
                      backgroundColor: ColorsManager.primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReview() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a review'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (widget.existingReview != null) {
      // Update existing review
      final request = UpdateReviewRequest(
        rating: _rating,
        comment: _commentController.text.trim(),
      );
      context.read<ReviewsCubit>().updateReview(
        widget.existingReview!.id,
        request,
      );
    } else {
      // Create new review
      final request = CreateReviewRequest(
        appointmentId: widget.appointmentId,
        rating: _rating,
        comment: _commentController.text.trim(),
      );
      context.read<ReviewsCubit>().createReview(request);
    }
  }
}
