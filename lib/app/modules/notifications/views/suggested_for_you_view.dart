import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';

class SuggestedForYouView extends GetView {
  const SuggestedForYouView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Suggested For You'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back,scale: 4,),
        ),
      ),
      body: const Center(
        child: Text(
          'Suggested For You is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
