import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/profile/ui/widgets/faq_category_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

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
        title: Text('Help Center', style: TextStyles.font18DarkGreenBold),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frequently Asked Questions',
                style: TextStyles.font16DarkGreenBold,
              ),
              verticalSpacing(20),
              FaqCategorySection(
                title: 'Account',
                icon: Iconsax.user,
                items: const [
                  FaqItem(
                    question: 'How do I create an account?',
                    answer:
                        'To create an account, tap on the "Sign Up" button on the login screen, fill in your details, and verify your email address.',
                  ),
                  FaqItem(
                    question: 'How do I reset my password?',
                    answer:
                        'Tap on "Forgot Password" on the login screen, enter your email, and follow the instructions sent to your email.',
                  ),
                  FaqItem(
                    question: 'How do I update my profile?',
                    answer:
                        'Go to Profile > Edit Profile, update your information, and tap "Save Changes".',
                  ),
                  FaqItem(
                    question: 'Can I change my email address?',
                    answer:
                        'Currently, email addresses cannot be changed. Please contact support if you need assistance.',
                  ),
                ],
              ),
              verticalSpacing(16),
              FaqCategorySection(
                title: 'Appointments',
                icon: Iconsax.calendar,
                items: const [
                  FaqItem(
                    question: 'How do I book an appointment?',
                    answer:
                        'Browse doctors by specialty, select a doctor, choose an available time slot, and confirm your booking.',
                  ),
                  FaqItem(
                    question: 'Can I reschedule my appointment?',
                    answer:
                        'Yes, go to your appointment details and tap "Reschedule" to select a new time slot.',
                  ),
                  FaqItem(
                    question: 'How do I cancel an appointment?',
                    answer:
                        'Go to your appointment details and tap "Cancel Appointment". Please note cancellation policies may apply.',
                  ),
                  FaqItem(
                    question: 'Will I receive appointment reminders?',
                    answer:
                        'Yes, you\'ll receive push notifications and email reminders before your scheduled appointments.',
                  ),
                ],
              ),
              verticalSpacing(16),
              FaqCategorySection(
                title: 'Payments',
                icon: Iconsax.wallet,
                items: const [
                  FaqItem(
                    question: 'What payment methods are accepted?',
                    answer:
                        'We accept credit cards, debit cards, and mobile payment methods like Apple Pay and Google Pay.',
                  ),
                  FaqItem(
                    question: 'Is my payment information secure?',
                    answer:
                        'Yes, all payments are processed through secure, encrypted payment gateways that comply with industry standards.',
                  ),
                  FaqItem(
                    question: 'How do I view my payment history?',
                    answer:
                        'Go to Profile > Payment History to view all your past transactions.',
                  ),
                  FaqItem(
                    question: 'Can I get a refund?',
                    answer:
                        'Refund policies depend on the cancellation timing. Contact support for specific cases.',
                  ),
                ],
              ),
              verticalSpacing(16),
              FaqCategorySection(
                title: 'Privacy',
                icon: Iconsax.shield,
                items: const [
                  FaqItem(
                    question: 'How is my data protected?',
                    answer:
                        'We use industry-standard encryption and security measures to protect your personal and medical information.',
                  ),
                  FaqItem(
                    question: 'Who can see my medical records?',
                    answer:
                        'Only you and the doctors you\'ve consulted with can access your medical records.',
                  ),
                  FaqItem(
                    question: 'Can I delete my account?',
                    answer:
                        'Yes, contact our support team to request account deletion. Please note this action is permanent.',
                  ),
                  FaqItem(
                    question: 'Do you share my data with third parties?',
                    answer:
                        'We do not share your personal data with third parties except as required for service delivery. See our Privacy Policy for details.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
