import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tails_date/app/modules/onboarding/views/widgets/onboardingwidget.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../auth_landing/views/auth_landing_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnboardingPage(
                image: AppImages.onboardingOne,
                title: 'Onboarding_One_Title'.tr,
                subtitle: 'Onboarding_One_Subtitle'.tr,
                highlightedText: [
                  'Onboarding_One_Highlight_Memories'.tr,
                  'Onboarding_One_Highlight_New'.tr,
                ],
              ),
              OnboardingPage(
                image: AppImages.onboardingTwo,
                title: 'Onboarding_Two_Title'.tr,
                subtitle: 'Onboarding_Two_Subtitle'.tr,
                highlightedText: ['Onboarding_Two_Highlight_Make'.tr],
              ),
              OnboardingPage(
                image: AppImages.onboardingThree,
                title: 'Onboarding_Three_Title'.tr,
                subtitle: 'Onboarding_Three_Subtitle'.tr,
                highlightedText: ['Onboarding_Three_Highlight_Financial'.tr],
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 40,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    spacing: 16.0,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 40,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                LocalStorage.saveData(
                    key: AppConstant.onboardingDone, data: "onboardingDone");
                if (_pageController.page != null) {
                  final nextPage = (_pageController.page! + 1).toInt();
                  if (nextPage < 3) {
                    _pageController.animateToPage(
                      nextPage,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Get.to(() => AuthLandingView());
                  }
                }
              },
              child: Container(
                height: 54,
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColors.black,
                ),
                child: Image.asset(
                  AppImages.arrowRight,
                  scale: 4,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 16,
            child: TextButton(
              onPressed: () {
                LocalStorage.saveData(
                    key: AppConstant.onboardingDone, data: "onboardingDone");
                Get.to(() => AuthLandingView());
              },
              child: Text(
                'Skip'.tr,
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}