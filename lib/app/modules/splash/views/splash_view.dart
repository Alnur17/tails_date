import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/onboarding/views/onboarding_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/local_store.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../login/views/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      return chooseScreen();
    });
  }

  chooseScreen() {
    var userToken = LocalStorage.getData(key: AppConstant.token);

    var  onboardingDone = LocalStorage.getData(key: AppConstant.onboardingDone);

    if (userToken != null) {
      Get.offAll(
        () => DashboardView(),
        transition: Transition.rightToLeft,
      );
    } else {

      if(onboardingDone != null){
        Get.offAll(
              () => LoginView(),
          transition: Transition.rightToLeft,
        );
      }else{
        Get.offAll(
              () => OnboardingView(),
          transition: Transition.rightToLeft,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Image.asset(
          AppImages.splashLogo,
          scale: 4,
        ),
      ),
    );
  }
}
