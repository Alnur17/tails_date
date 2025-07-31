import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/home/views/my_search_view.dart';
import 'package:tails_date/app/modules/home/views/widgets/category_widgets/category_widget.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/stories_section.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/app/modules/notifications/views/notifications_view.dart';
import 'package:tails_date/app/modules/profile/controllers/collections_controller.dart';
import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';

import 'category_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //final SignupController signupController = Get.put(SignupController());
  final HomeController homeController = Get.put(HomeController());
  final CollectionsController collectionsController =
      Get.put(CollectionsController());
  final ProfileController profileController =
      Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return homeController.fetchPosts();
      },
      child: Scaffold(
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
                Get.to(() => MySearchView());
              },
              child: Image.asset(
                AppImages.search,
                scale: 4,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => NotificationsView());
              },
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
        body: Obx(() => homeController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.black,
              ))
            : homeController.errorMessage.value.isNotEmpty
                ? Center(
                    child: Text(homeController.errorMessage.value, style: h5))
                : SingleChildScrollView(
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
                            style: h1.copyWith(
                                fontSize: 20, color: AppColors.black),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Obx(
                            () => Row(
                              children: List.generate(
                                homeController.categories.length + 1,
                                (index) {
                                  if (index <
                                      homeController.categories.length) {
                                    final categoryData =
                                        homeController.categories[index];
                                    return CategoryWidget(
                                      name: categoryData.name ?? 'Unknown',
                                      backImage:
                                          categoryData.image ?? 'Unknown',
                                      categoryId: categoryData.id,
                                      onTap: () {
                                        Get.to(() => CategoryView(
                                              categoryName:
                                                  categoryData.name ?? '',
                                              categoryId: categoryData.id ?? '',
                                            ));
                                        debugPrint(
                                            'Category Id is : ${categoryData.id}');
                                      },
                                    );
                                  } else {
                                    return const SizedBox(width: 16);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        // Posts Section
                        Column(
                          children: List.generate(
                            homeController.posts.length,
                            (index) {
                              final post = homeController.posts[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      index == homeController.posts.length - 1
                                          ? 30
                                          : 0,
                                  right: 16,
                                  left: 16,
                                  top: 16,
                                ),
                                child: UserPostCard(
                                  postId: post.id ?? '',
                                  userName: post.author?.name ?? 'Unknown',
                                  location: post.location ?? 'Unknown',
                                  profileImage: post.author?.image ?? '',
                                  images: post.images,
                                  description: post.caption ?? '',
                                  likeCount: post.reactions.length,
                                  timeAgo: homeController
                                      .formatTimeAgo(post.createdAt),
                                  onAddFriend: () {
                                    log("Add Friend clicked for ${post.author?.name}");
                                  },
                                  onBookmark: () {
                                    log("Bookmark button clicked for post ID: ${post.id}");
                                    if (post.id == null || post.id!.isEmpty) {
                                      log("Error: Post ID is null or empty");
                                      return;
                                    }
                                    collectionsController.addOrRemoveCollection(post.id!);
                                  },
                                  onReaction: () {
                                    log("Reaction button clicked for post ID: ${post.id}");
                                    if (post.id == null || post.id!.isEmpty) {
                                      log("Error: Post ID is null or empty");
                                      return;
                                    }
                                    homeController.addOrRemoveReaction(post.id!);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
