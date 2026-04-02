import 'package:doctor_mate/core/helper/app_images.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/features/onBoarding/data/models/onBoarding_model.dart';
import 'package:doctor_mate/features/onBoarding/ui/widgets/navigation_onboarding.dart';
import 'package:doctor_mate/features/onBoarding/ui/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // PageController to control the page view
  // and track the current page index
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Sample data for onboarding items
    List<OnboardingModel> onboardingList = [
      OnboardingModel(
        image: AppImages.onBoarding1,
        title: "Find The Best Doctors in DoctorMate",
        description:
            "We will assist you in efficiently and easily scheduling appointments with doctors.Let's get started!",
      ),
      OnboardingModel(
        image: AppImages.onBoarding2,
        title: "Find The Best Caretaker For You in DoctorMate",
        description:
            "Select the medical specialization you need so we can tailor your experience.",
      ),
      OnboardingModel(
        image: AppImages.onBoarding3,
        title: "Schedule Your First Appointment in DoctorMate",
        description:
            "Choose a suitable time and date to meet your preferred doctor. Begin your journey to better health!",
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:
                MediaQuery.of(
                  context,
                ).size.height, // Constrain height to screen size
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //verticalSpacing(61),
              // PageView to display onboarding items
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingItem(model: onboardingList[index]);
                  },
                  itemCount: onboardingList.length,
                ),
              ),
              verticalSpacing(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: NavigationOnBoarding(
                  currentPage: _currentPage,
                  pageController: _pageController,
                  onboardingList: onboardingList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
