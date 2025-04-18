import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tails_date/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tails_date/app/modules/onboarding/views/widgets/onboardingwidget.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';

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
                title: "Create Memories Meet New Friends",
                subtitle:
                    "Connect with fellow pet lovers in your area, \nChat, arrange Tailsdates.",
                highlightedText: ["Memories", "New"],
                //backgroundImage: AppImages.onboardingBackOne,
              ),
              OnboardingPage(
                image: AppImages.onboardingTwo,
                title: "Let’s Make Your Pet A Star!",
                subtitle:
                    "Snap, share and shine – Turn every moment, wag, purr and cuddle in to a story worth telling.",
                highlightedText: ["Make"],
                //backgroundImage: AppImages.onboardingBackTwo,
              ),
              OnboardingPage(
                image: AppImages.onboardingThree,
                title: "Earn Financial \n Rewards",
                subtitle:
                    "Receive recognition and monetary benefits for your pet photography.",
                highlightedText: ["Financial"],
                //backgroundImage: AppImages.onboardingBackTwo,
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
                Get.to(() => DashboardView());
              },
              child: Text(
                "Skip",
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
