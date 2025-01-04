import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';

class SendRequestView extends GetView {
  const SendRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Send Request'),
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
          'Send Request is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
