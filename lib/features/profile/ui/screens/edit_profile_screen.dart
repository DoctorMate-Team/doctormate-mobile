import 'dart:io';

import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/features/auth/ui/widgets/custom_profile_screen_image.dart';
import 'package:doctor_mate/features/profile/ui/widgets/profile_form_prefix_icon.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_cubit.dart';
import 'package:doctor_mate/features/profile/logic/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_mate/features/profile/data/models/profile_response_model.dart';

/// Performance optimizations applied:
/// - Const widgets for static UI elements (icons, text)
/// - Separated BlocListener and BlocBuilder to minimize rebuilds
/// - Reusable ImagePicker instance
/// - Image compression (maxWidth, maxHeight, quality)
/// - Extracted validator functions
/// - Optimized buildWhen/listenWhen conditions

class EditProfileScreen extends StatefulWidget {
  final ProfileResponseModel profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  // Reuse ImagePicker instance for better performance
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _currentImageUrl;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.profile.fullName);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _addressController = TextEditingController(text: widget.profile.address);
    _currentImageUrl = widget.profile.imageUrl;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024, // Limit image size for better performance
      maxHeight: 1024,
      imageQuality: 85, // Compress image to reduce memory usage
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileCubit>().updateProfileDetails(
        fullName: _fullNameController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        imagePath: _selectedImage?.path,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: ColorsManager.primaryColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text('Edit Profile', style: TextStyles.font18DarkGreenBold),
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listenWhen:
            (previous, current) =>
                current is UpdateProfileDetailsSuccess ||
                current is UpdateProfileDetailsError,
        listener: (context, state) {
          state.maybeWhen(
            updateProfileDetailsSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              context.pop(true);
            },
            updateProfileDetailsError: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen:
              (previous, current) =>
                  current is UpdateProfileDetailsLoading ||
                  current is UpdateProfileDetailsSuccess ||
                  current is UpdateProfileDetailsError,
          builder: (context, state) {
            final isLoading = state is UpdateProfileDetailsLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomProfileScreenImage(
                        imageUrl: _currentImageUrl,
                        imageFile: _selectedImage,
                        onTap: _pickImage,
                        isEdit: true,
                      ),
                      verticalSpacing(32),

                      // Full Name Field
                      CustomTextFormField(
                        controller: _fullNameController,
                        hintText: 'Full Name',
                        keyboardType: TextInputType.name,
                        prefix: const ProfileFormPrefixIcon(icon: Iconsax.user),
                        validator: _validateRequired(
                          'Please enter your full name',
                        ),
                      ),
                      verticalSpacing(20),

                      // Phone Number Field
                      CustomTextFormField(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        prefix: const ProfileFormPrefixIcon(icon: Iconsax.call),
                        validator: _validateRequired(
                          'Please enter your phone number',
                        ),
                      ),
                      verticalSpacing(20),

                      // Address Field
                      CustomTextFormField(
                        controller: _addressController,
                        hintText: 'Address',
                        keyboardType: TextInputType.streetAddress,
                        prefix: const ProfileFormPrefixIcon(
                          icon: Iconsax.location,
                        ),
                        validator: _validateRequired(
                          'Please enter your address',
                        ),
                      ),
                      verticalSpacing(40),

                      // Save Button
                      CustomMaterialButton(
                        textButton: isLoading ? 'Saving...' : 'Save Changes',
                        onPressed: isLoading ? () {} : _onSave,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Extracted validator function to reduce code duplication
  String? Function(String?) _validateRequired(String errorMessage) {
    return (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
      return null;
    };
  }
}
