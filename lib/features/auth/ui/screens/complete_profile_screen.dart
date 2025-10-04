import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_drop_down_form_field.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/core/widgets/date_picker_form_field.dart';
import 'package:doctor_mate/features/auth/ui/widgets/custom_profile_screen_image.dart';
import 'package:doctor_mate/features/auth/ui/widgets/terms_and_conditions_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _contentController;

  late Animation<double> _contentFadeAnimation;
  late Animation<Offset> _contentSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Setup content animations
    _contentFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeInOut),
    );

    _contentSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOutBack),
    );

    // Start animations with staggered timing
    _startAnimations();
  }

  void _startAnimations() async {
    // Start header animation immediately
    _headerController.forward();

    // Wait then start content animation
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      _contentController.forward();
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomMaterialButton(
                textButton: "Complete Profile",
                onPressed: () {
                  // Handle profile completion
                },
              ),
              verticalSpacing(16),
              const TermsAndConditionsText(),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _contentController,
          builder: (context, child) {
            return SlideTransition(
              position: _contentSlideAnimation,
              child: FadeTransition(
                opacity: _contentFadeAnimation,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Complete your profile",
                        style: TextStyles.font20GreenBold,
                      ),
                      verticalSpacing(16),
                      Text(
                        "Please take a few minutes to fill out your profile with as much detail as possible",
                        textAlign: TextAlign.center,
                        style: TextStyles.font14GrayRegular,
                      ),
                      verticalSpacing(32),
                      Center(
                        child: CustomProfileScreenImage(
                          onTap: () {
                            // Handle image selection
                          },
                          isEdit: true,
                        ),
                      ),
                      verticalSpacing(32),
                      CustomTextFormField(
                        hintText: "Address",
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(16),
                      DatePickerFormField(
                        hintText: "Date of Birth",
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please select your date of birth';
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(16),
                      CustomDropDownFormField(
                        hintText: "Gender",
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your gender';
                          }
                          return null;
                        },
                        listOfValues: ["Male", "Female"],
                      ),
                      verticalSpacing(16),
                      CustomDropDownFormField(
                        hintText: "Blood Type",
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your blood type';
                          }
                          return null;
                        },
                        listOfValues: [
                          "O+",
                          "O-",
                          "A+",
                          "A-",
                          "B+",
                          "B-",
                          "AB+",
                          "AB-",
                        ],
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
}
