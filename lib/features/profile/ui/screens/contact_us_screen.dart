import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/core/widgets/custom_text_form_field.dart';
import 'package:doctor_mate/features/profile/logic/cubit/contact_cubit.dart';
import 'package:doctor_mate/features/profile/logic/cubit/contact_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _messageController;

  String _selectedSubject = 'General Inquiry';
  final List<String> _subjects = [
    'General Inquiry',
    'Technical Support',
    'Billing Issue',
    'Appointment Issue',
    'Feedback',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<ContactCubit>().submitContactForm(
        name: _nameController.text,
        email: _emailController.text,
        subject: _selectedSubject,
        message: _messageController.text,
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
        title: Text('Contact Us', style: TextStyles.font18DarkGreenBold),
      ),
      body: BlocListener<ContactCubit, ContactState>(
        listenWhen: (previous, current) =>
            current is SubmitContactSuccess ||
            current is SubmitContactError,
        listener: (context, state) {
          state.maybeWhen(
            submitContactSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Message sent successfully! We\'ll get back to you soon.',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              context.pop();
            },
            submitContactError: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<ContactCubit, ContactState>(
          buildWhen: (previous, current) => current is SubmitContactLoading,
          builder: (context, state) {
            final isLoading = state is SubmitContactLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get in Touch',
                        style: TextStyles.font16DarkGreenBold,
                      ),
                      verticalSpacing(8),
                      Text(
                        'Have questions? We\'d love to hear from you.',
                        style: TextStyles.font14GrayRegular,
                      ),
                      verticalSpacing(32),

                      // Name Field
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: 'Your Name',
                        keyboardType: TextInputType.name,
                        prefix: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const Icon(
                            Iconsax.user,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(20),

                      // Email Field
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'Your Email',
                        keyboardType: TextInputType.emailAddress,
                        prefix: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const Icon(
                            Iconsax.sms,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(20),

                      // Subject Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedSubject,
                        decoration: InputDecoration(
                          hintText: 'Subject',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: const Icon(
                              Iconsax.message_text,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                        items:
                            _subjects
                                .map(
                                  (subject) => DropdownMenuItem(
                                    value: subject,
                                    child: Text(subject),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSubject = value!;
                          });
                        },
                      ),
                      verticalSpacing(20),

                      // Message Field
                      CustomTextFormField(
                        controller: _messageController,
                        hintText: 'Your Message',
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        prefix: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const Icon(
                            Iconsax.edit,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your message';
                          }
                          if (value.length < 10) {
                            return 'Message must be at least 10 characters';
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(40),

                      // Submit Button
                      CustomMaterialButton(
                        textButton: isLoading ? 'Sending...' : 'Send Message',
                        onPressed: isLoading ? () {} : _onSubmit,
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
