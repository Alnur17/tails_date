import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/views/search_view.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/stories_section.dart';
import 'package:tails_date/app/modules/profile/views/profile_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.guColor,
      appBar: AppBar(
        backgroundColor: AppColors.guColor,
        title: Text(
          'TailsDate',
          style: h2.copyWith(fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(()=> SearchView());
            },
            child: Image.asset(
              AppImages.search,
              scale: 4,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(()=> ProfileView());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 24,right: 16),
              child: Image.asset(
                AppImages.profile,
                scale: 4,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const StoriesSection(),
        ],
      ),
    );
  }
}
