import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/theme/font_weight_helper.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/core/widgets/horizantal_line_space.dart';
import 'package:doctor_mate/features/booking_appointment/data/models/appointment_response_body.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_cubit.dart';
import 'package:doctor_mate/features/booking_appointment/logic/cubit/appointment_state.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/summary_booking/appointment_type_summary.dart';
import 'package:doctor_mate/features/booking_appointment/ui/widgets/summary_booking/date_and_time_summary.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AppointmentSuccessScreen extends StatefulWidget {
  final AppointmentModel? appointmentData;

  const AppointmentSuccessScreen({super.key, this.appointmentData});

  @override
  State<AppointmentSuccessScreen> createState() =>
      _AppointmentSuccessScreenState();
}

class _AppointmentSuccessScreenState extends State<AppointmentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        state.whenOrNull(
          uploadMedicalImageSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Medical image uploaded successfully'),
                backgroundColor: ColorsManager.green,
              ),
            );
            // Clear selected images after successful upload
            setState(() {
              _selectedImages.clear();
            });
          },
          uploadMedicalImageError: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        verticalSpacing(40),
                        // Success Icon Animation
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 120.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  ColorsManager.green,
                                  Color(0xFF4CAF50),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorsManager.green.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              size: 70.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        verticalSpacing(32),
                        // Success Message
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'Booking Confirmed!',
                                style: TextStyles.font18DarkGreenBold.copyWith(
                                  fontSize: 24.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              verticalSpacing(12),
                              Text(
                                'Your appointment has been successfully booked',
                                style: TextStyles.font14GrayRegular,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        verticalSpacing(40),
                        // Booking Details Card
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: ColorsManager.moreLighterGray,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorsManager.lightGray.withOpacity(
                                    0.1,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                        color: ColorsManager.lighterMainBlue,
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.calendar_month_rounded,
                                        color: ColorsManager.primaryColor,
                                        size: 20.sp,
                                      ),
                                    ),
                                    horizantialSpacing(12),
                                    Text(
                                      'Booking Information',
                                      style: TextStyles.font15DarkGreenMedium
                                          .copyWith(
                                            fontWeight:
                                                FontWeightHelper.semiBold,
                                          ),
                                    ),
                                  ],
                                ),
                                verticalSpacing(20),
                                // Booking Reference
                                if (widget.appointmentData?.id != null) ...[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorsManager.lighterMainBlue,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.bookmark_rounded,
                                          size: 16.sp,
                                          color: ColorsManager.primaryColor,
                                        ),
                                        horizantialSpacing(6),
                                        Text(
                                          'Ref: ${widget.appointmentData!.id.substring(0, 8).toUpperCase()}',
                                          style: TextStyles.font12GrayRegular
                                              .copyWith(
                                                color:
                                                    ColorsManager.primaryColor,
                                                fontWeight:
                                                    FontWeightHelper.medium,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  verticalSpacing(16),
                                ],
                                DateAndTimeSummary(
                                  selectedDate:
                                      widget.appointmentData != null
                                          ? DateFormat('yyyy-MM-dd').format(
                                            widget
                                                .appointmentData!
                                                .appointmentDate,
                                          )
                                          : null,
                                  selectedTime:
                                      widget.appointmentData?.appointmentTime,
                                ),
                                verticalSpacing(16),
                                const HorizantalLineSpace(),
                                verticalSpacing(16),
                                AppointmentTypeSummary(
                                  appointmentType:
                                      widget.appointmentData?.appointmentType ==
                                              'video'
                                          ? 0
                                          : widget
                                                  .appointmentData
                                                  ?.appointmentType ==
                                              'voice'
                                          ? 1
                                          : 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpacing(24),
                        // Doctor Info Card
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: EdgeInsets.all(20.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: ColorsManager.moreLighterGray,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorsManager.lightGray.withOpacity(
                                    0.1,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                        color: ColorsManager.lightGreen,
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.person_rounded,
                                        color: ColorsManager.green,
                                        size: 20.sp,
                                      ),
                                    ),
                                    horizantialSpacing(12),
                                    Text(
                                      'Doctor Information',
                                      style: TextStyles.font15DarkGreenMedium
                                          .copyWith(
                                            fontWeight:
                                                FontWeightHelper.semiBold,
                                          ),
                                    ),
                                  ],
                                ),
                                verticalSpacing(16),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Container(
                                        width: 60.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          image:
                                              widget
                                                          .appointmentData
                                                          ?.doctor
                                                          .image !=
                                                      null
                                                  ? DecorationImage(
                                                    image: NetworkImage(
                                                      widget
                                                          .appointmentData!
                                                          .doctor
                                                          .image,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )
                                                  : null,
                                          color:
                                              widget
                                                          .appointmentData
                                                          ?.doctor
                                                          .image ==
                                                      null
                                                  ? ColorsManager
                                                      .moreLighterGray
                                                  : null,
                                        ),
                                        child:
                                            widget
                                                        .appointmentData
                                                        ?.doctor
                                                        .image ==
                                                    null
                                                ? Icon(
                                                  Icons.person,
                                                  size: 30.sp,
                                                  color:
                                                      ColorsManager.lightGray,
                                                )
                                                : null,
                                      ),
                                    ),
                                    horizantialSpacing(12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget
                                                    .appointmentData
                                                    ?.doctor
                                                    .doctorName ??
                                                'Doctor Name',
                                            style: TextStyles
                                                .font14GreenSemiBold
                                                .copyWith(
                                                  color: ColorsManager.darkBlue,
                                                ),
                                          ),
                                          verticalSpacing(4),
                                          Text(
                                            widget
                                                    .appointmentData
                                                    ?.doctor
                                                    .specialtyName ??
                                                'Specialty',
                                            style: TextStyles.font12GrayRegular,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpacing(24),
                        // Medical Images Upload Section
                        if (widget.appointmentData?.id != null) ...[
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildMedicalImageUploadSection(),
                          ),
                          verticalSpacing(24),
                        ],
                      ],
                    ),
                  ),
                ),
                // Action Buttons
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      CustomMaterialButton(
                        textButton: 'Back to Home',
                        onPressed: () {
                          context.goNamed(Routes.mainLayout);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalImageUploadSection() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.moreLighterGray, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.lightGray.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.upload_file_rounded,
                  color: Colors.purple,
                  size: 20.sp,
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medical Images (Optional)',
                      style: TextStyles.font15DarkGreenMedium.copyWith(
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                    verticalSpacing(2),
                    Text(
                      'Upload X-Rays, DICOM, or other medical images',
                      style: TextStyles.font12GrayRegular.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(16),
          // Image Selection Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(
                    Icons.photo_library_rounded,
                    size: 18.sp,
                    color: ColorsManager.primaryColor,
                  ),
                  label: Text(
                    'Gallery',
                    style: TextStyle(
                      color: ColorsManager.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeightHelper.medium,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    side: const BorderSide(color: ColorsManager.primaryColor),
                  ),
                ),
              ),
              horizantialSpacing(12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    size: 18.sp,
                    color: ColorsManager.primaryColor,
                  ),
                  label: Text(
                    'Camera',
                    style: TextStyle(
                      color: ColorsManager.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeightHelper.medium,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    side: const BorderSide(color: ColorsManager.primaryColor),
                  ),
                ),
              ),
            ],
          ),
          // Selected Images Grid
          if (_selectedImages.isNotEmpty) ...[
            verticalSpacing(16),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: ColorsManager.moreLighterGray,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selected Images (${_selectedImages.length})',
                        style: TextStyles.font12GrayRegular.copyWith(
                          fontWeight: FontWeightHelper.medium,
                          color: ColorsManager.darkBlue,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedImages.clear();
                          });
                        },
                        child: Text(
                          'Clear All',
                          style: TextStyle(color: Colors.red, fontSize: 11.sp),
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      childAspectRatio: 1,
                    ),
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              File(_selectedImages[index].path),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImages.removeAt(index);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            verticalSpacing(12),
            // Upload Button
            BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) {
                final isUploading = state.maybeWhen(
                  uploadMedicalImageLoading: () => true,
                  orElse: () => false,
                );
                return CustomMaterialButton(
                  textButton: isUploading ? 'Uploading...' : 'Upload Images',
                  onPressed: isUploading ? () {} : _uploadImages,
                  backgroundColor:
                      isUploading ? ColorsManager.lightGray : Colors.purple,
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        // Allow multiple images from gallery
        final List<XFile> images = await _imagePicker.pickMultiImage();
        if (images.isNotEmpty) {
          setState(() {
            _selectedImages.addAll(images);
          });
        }
      } else {
        // Single image from camera
        final XFile? image = await _imagePicker.pickImage(source: source);
        if (image != null) {
          setState(() {
            _selectedImages.add(image);
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _uploadImages() {
    if (_selectedImages.isEmpty || widget.appointmentData?.id == null) return;

    // Upload first image (you can modify to upload all)
    final firstImage = _selectedImages.first;
    context.read<AppointmentCubit>().uploadMedicalImage(
      appointmentId: widget.appointmentData!.id,
      imagePath: firstImage.path,
    );
  }
}
