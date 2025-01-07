import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/my_search_controller.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';


class SearchView extends GetView<MySearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final MySearchController searchController = Get.put(MySearchController());

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
          sh20,
          Expanded(child: Obx(
            () {
              final posts = searchController.filteredPosts;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index == posts.length - 1 ? 30 : 0),
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
                        log("Add Friend clicked for ${post['userName']}");
                      },
                      videoThumbnails:
                          List<String>.from(post['videoThumbnails'] ?? []),
                    ),
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
