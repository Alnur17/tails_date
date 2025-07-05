import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/common/app_color/app_colors.dart';

import '../../../../common/app_images/app_images.dart';

class CategoryView extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  const CategoryView({super.key, required this.categoryName, required this.categoryId});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // final filteredPosts = DummyData.posts.where((post) {
    //   return post['category'] == categoryName;
    // }).toList();

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text(widget.categoryName),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: ListView.builder(
        //padding: EdgeInsets.all(16),
        itemCount: homeController.posts.length,
        itemBuilder: (context, index) {
          final post = homeController.posts[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == homeController.posts.length - 1 ? 30 : 0,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: UserPostCard(
              userName: post.author?.name ?? 'Unknown',
              location: post.location ?? 'Unknown',
              profileImage: post.author?.image ?? '',
              images: post.images,
              description: post.caption ?? '',
              likeCount: 0, // Adjust if API provides like count
              timeAgo: homeController.formatTimeAgo(post.createdAt),
              onAddFriend: () {
                log("Add Friend clicked for ${post.author?.name}");
              },
            ),
          );
        },
      ),
    );
  }
}
