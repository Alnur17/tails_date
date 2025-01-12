import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/common/app_color/app_colors.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../data/dummy_data.dart';

class CategoryView extends StatelessWidget {
  final String categoryName;

  const CategoryView({super.key, required this.categoryName});

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
        title: Text(categoryName),
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
        itemCount: DummyData.posts.length,
        itemBuilder: (context, index) {
          final post = DummyData.posts[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == DummyData.posts.length - 1 ? 30 : 0,
              left: 16,
              right: 16,
              top: 16,
            ),
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
              videoThumbnails: List<String>.from(post['videoThumbnails'] ?? []),
            ),
          );
        },
      ),
    );
  }
}
