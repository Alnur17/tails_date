import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/data/dummy_data.dart';
import 'package:tails_date/app/modules/home/views/search_view.dart';
import 'package:tails_date/app/modules/home/views/widgets/category_widgets/category_widget.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/stories_section.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
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
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'TailsDate',
          style: h2.copyWith(fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => SearchView());
            },
            child: Image.asset(
              AppImages.search,
              scale: 4,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => ProfileView());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 16),
              child: Image.asset(
                AppImages.profile,
                scale: 4,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stories Section
            const StoriesSection(),

            // Categories Section
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                'Categories',
                style: h1.copyWith(fontSize: 20, color: AppColors.black),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  DummyData.categoryName.length + 1,
                  (index) {
                    if (index < DummyData.categoryName.length) {
                      return CategoryWidget(
                        name: DummyData.categoryName[index],
                        backImage: DummyData.categoryImage[index],
                      );
                    } else {
                      return const SizedBox(width: 16);
                    }
                  },
                ),
              ),
            ),
            Column(
              children: List.generate(
                DummyData.posts.length,
                (index) {
                  final post = DummyData.posts[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index == DummyData.posts.length - 1 ? 30 : 0,right: 16,left: 16,top: 16),
                    child: UserPostCard(
                      userName: post['userName'] ?? '',
                      location: post['location'] ?? '',
                      profileImage: post['profileImage'] ?? '',
                      images: List<String>.from(post['images'] ?? []),
                      videos: List<String>.from(post['videos'] ?? []),
                      description: post['description'] ?? '',
                      likeCount: post['likeCount'] ?? 0,
                      timeAgo: post['timeAgo'] ?? '',
                      onAddFriend: () {
                        print("Add Friend clicked for ${post['userName']}");
                      },
                      videoThumbnails:
                          List<String>.from(post['videoThumbnails'] ?? []),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
