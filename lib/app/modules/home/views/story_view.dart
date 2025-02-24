import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/data/dummy_data.dart';
import 'package:tails_date/common/app_images/app_images.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../profile/views/buy_star_view.dart';
import '../../profile/views/send_stars_view.dart';
import '../controllers/story_controller.dart';

class StoryView extends GetView {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final StoryController controller = Get.put(StoryController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Obx(() {
          return Stack(
            children: [
              GestureDetector(
                onTapUp: (details) {
                  if (details.globalPosition.dx < Get.width / 2) {
                    controller.goToPreviousStory();
                  } else {
                    controller.goToNextStory(DummyData.storyImageUrls);
                  }
                },
                child: Image.network(
                  DummyData.storyImageUrls[controller.currentIndex.value],
                  fit: BoxFit.cover,
                  height: Get.height,
                ),
              ),
              // Semi-transparent overlay at the top for user info
              Positioned(
                top: 0,
                left: 10,
                right: 10,
                bottom: Get.height * 0.83,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black.withOpacity(0.7),
                        AppColors.black.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Story user profile and close button
              Positioned(
                top: 30,
                left: 25,
                right: 80,
                child: GestureDetector(
                  onTap: () {
                    log('tap image profile');
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            DummyData
                                .storyImageUrls[controller.currentIndex.value],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      sw10,
                      Expanded(
                        child: Text(
                          'Username', // Replace with dynamic username if needed
                          style: h3.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),

              Positioned(
                top: Get.height * 0.8,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black.withOpacity(0.6),
                        AppColors.black.withOpacity(0.1),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 75,
                bottom: 30,
                child: Text(
                  'Description should be added here. Description should be added here.Description should be added here. Description should be added here. Description should be added here. Description should be added here.',
                  style: h5.copyWith(color: AppColors.white),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 16,
                child: Column(
                  children: [
                    IconButton(
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.black38),
                      icon: Image.asset(
                        AppImages.star,
                        scale: 4,
                        color: AppColors.white,
                      ),
                      onPressed: () => showStarBuyDialog(context),
                    ),
                    sh5,
                    IconButton(
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.black38),
                      icon: Image.asset(
                        AppImages.heart,
                        scale: 4,
                        color: AppColors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // Progress indicator at the top
              Positioned(
                top: 10,
                left: 15,
                right: 15,
                child: Row(
                  children: DummyData.storyImageUrls.map((url) {
                    int index = DummyData.storyImageUrls.indexOf(url);
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Obx(() {
                          return LinearProgressIndicator(
                            value: index < controller.currentIndex.value
                                ? 1.0
                                : index == controller.currentIndex.value
                                    ? controller.progress.value
                                    : 0.0,
                            backgroundColor: Colors.grey,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          );
                        }),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void showStarBuyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.gradientColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Support what you love! 🌟',
                      style: h3, textAlign: TextAlign.center),
                  Image.asset(AppImages.starImage, scale: 4),
                  const SizedBox(height: 8),
                  CustomButton(
                    onPressed: () => Get.to(() => BuyStarView()),
                    text: "Buy Star 🌟",
                    backgroundColor: AppColors.white,
                    textStyle: h3.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text('OR', style: h3),
                  const SizedBox(height: 8),
                  CustomButton(
                    onPressed: () => Get.to(() => SendStarsView()),
                    text: "Send Stars 🤩",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
