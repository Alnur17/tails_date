
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/data/dummy_data.dart';
import 'package:tails_date/app/modules/auth_landing/views/auth_landing_view.dart';
import 'package:tails_date/app/modules/auth_landing/views/widget/guest_user_post_card.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../home/views/widgets/category_widgets/category_widget.dart';
import '../../home/views/widgets/home_widgets/stories_section.dart';
import '../controllers/auth_home_controller.dart';

class GuestHomeView extends StatefulWidget {
  const GuestHomeView({super.key});

  @override
  State<GuestHomeView> createState() => _GuestHomeViewState();
}

class _GuestHomeViewState extends State<GuestHomeView> {
  final AuthHomeController authHomeController =
  Get.isRegistered<AuthHomeController>()
      ? Get.find()
      : Get.put(AuthHomeController());

  void _showLoginPrompt() {
    Get.defaultDialog(
      title: 'Login Required',
      middleText: 'Please login to continue.',
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          // Navigate to login or auth page
          Get.offAll(() => AuthLandingView());
        },
        child: const Text('Login'),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
    );
  }

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
            onTap: _showLoginPrompt,
            child: Image.asset(
              AppImages.search,
              scale: 4,
            ),
          ),
          GestureDetector(
            onTap: _showLoginPrompt,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 16),
              child: Image.asset(
                AppImages.notification,
                scale: 4,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _showLoginPrompt,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StoriesSection(),
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
                    DummyData.categoryName.length,
                        (index) => CategoryWidget(
                      name: DummyData.categoryName[index],
                      backImage: DummyData.categoryImage[index],
                      categoryId: '123456 test',
                      onTap: _showLoginPrompt, // make category taps prompt login
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (authHomeController.isLoading.value) {
                  return const Center(
                      child:
                      CircularProgressIndicator(color: AppColors.black));
                } else if (authHomeController.errorMessage.value.isNotEmpty) {
                  return Center(
                      child:
                      Text(authHomeController.errorMessage.value, style: h5));
                } else {
                  return Column(
                    children: List.generate(
                      authHomeController.guestPosts.length,
                          (index) {
                        final post = authHomeController.guestPosts[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom:
                            index == authHomeController.guestPosts.length - 1
                                ? 30
                                : 0,
                            right: 16,
                            left: 16,
                            top: 16,
                          ),
                          child: GuestUserPostCard(
                            postId: post.id ?? '',
                            userName: post.author?.name ?? 'Unknown',
                            location: post.location ?? 'Unknown',
                            profileImage: post.author?.image ?? '',
                            images: post.images,
                            description: post.caption ?? '',
                            likeCount: post.reactions.length,
                            timeAgo:
                            authHomeController.formatTimeAgo(post.createdAt),
                            onAddFriend: _showLoginPrompt,
                            onBookmark: _showLoginPrompt,
                            onReaction: _showLoginPrompt,
                            onNotInterestedTap: _showLoginPrompt,
                            onOtherProfileTap: _showLoginPrompt,
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

