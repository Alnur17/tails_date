import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/splash/controllers/splash_controller.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      return splashController.chooseScreen();
    });
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
