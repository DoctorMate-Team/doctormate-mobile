import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/widgets/custom_material_button.dart';
import 'package:doctor_mate/features/onBoarding/data/models/onBoarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NavigationOnBoarding extends StatelessWidget {
  const NavigationOnBoarding({
    super.key,
    required int currentPage,
    required PageController pageController,
    required this.onboardingList,
  }) : _currentPage = currentPage,
       _pageController = pageController;

  final int _currentPage;
  final PageController _pageController;
  final List<OnboardingModel> onboardingList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmoothIndicator(
          offset: _currentPage.toDouble(),
          count: onboardingList.length,
          size: Size(16.w, 8.h),
          effect: const ExpandingDotsEffect(
            activeDotColor: ColorsManager.primaryColor,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 4,
          ),
        ),
        verticalSpacing(45),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _currentPage != 0
                ? Expanded(
                  child: CustomMaterialButton(
                    textButton: "Previous",
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    backgroundColor: Colors.white,
                    textColor: ColorsManager.primaryColor,
                  ),
                )
                : const SizedBox.shrink(),
            _currentPage != 0
                ? horizantialSpacing(17)
                : const SizedBox.shrink(),
            Expanded(
              child: CustomMaterialButton(
                textButton: "Next",
                onPressed: () {
                  if (_currentPage < onboardingList.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  } else {
                    // Navigate to the next screen or perform any action
                    GoRouter.of(context).pushNamed(Routes.auth);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
