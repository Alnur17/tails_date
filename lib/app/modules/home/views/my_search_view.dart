import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/home/controllers/my_search_controller.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../profile/controllers/collections_controller.dart';

class MySearchView extends GetView<MySearchController> {
  const MySearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final MySearchController searchController = Get.put(MySearchController());
    final HomeController homeController = Get.find<HomeController>();
    final CollectionsController collectionsController =
    Get.put(CollectionsController());

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 16,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AppImages.back,
                    scale: 4,
                  ),
                ),
                sw12,
                Expanded(
                  child: CustomTextField(
                    controller: searchController.searchController,
                    preIcon: Image.asset(
                      AppImages.searchTwo,
                      scale: 4,
                    ),
                    hintText: 'Search by name or location',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (homeController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    homeController.errorMessage.value,
                    style: const TextStyle(color: AppColors.orange, fontSize: 16),
                  ),
                );
              }
              final posts = searchController.filteredPosts;
              if (posts.isEmpty) {
                return const Center(
                  child: Text(
                    'No posts found',
                    style: TextStyle(color: AppColors.black, fontSize: 16),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == posts.length - 1 ? 30 : 0,
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: UserPostCard(
                      postId: post.id ?? '',
                      userName: post.author?.name ?? 'Unknown',
                      location: post.location ?? 'Unknown',
                      profileImage: post.author?.image ?? '',
                      images: post.images,
                      description: post.caption ?? '',
                      likeCount: 0,
                      timeAgo: homeController.formatTimeAgo(post.createdAt),
                      onAddFriend: () {
                        log("Add Friend clicked for ${post.author?.name}");
                      },
                      onBookmark: (){
                        collectionsController.addOrRemoveCollection(post.id!);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}