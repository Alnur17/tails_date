import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/local_store.dart';
import '../../home/views/widgets/home_widgets/user_post_card.dart';
import '../controllers/collections_controller.dart';
import 'other_profile_view.dart';

class CollectionsView extends GetView {
  const CollectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionsController controller = Get.put(CollectionsController());
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Collections'.tr),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.collections.isEmpty) {
          return Center(
            child: Text(
              'No_Collections_Found'.tr,
              style: h4,
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.collections.length,
          itemBuilder: (context, index) {
            final collection = controller.collections[index];
            final post = collection.post;
            return Padding(
              padding: EdgeInsets.only(top: 16, bottom: index == controller.collections.length - 1 ? 16 : 0),
              child: UserPostCard(
                isLiked: homeController.isPostLiked(post?.id ?? ''),
                isSaved: homeController.isPostInCollections(post?.id ?? ''),
                isMe: post?.author?.id == LocalStorage.getData(key: AppConstant.userId),
                isFriend: true,
                onNotInterestedTap: () {
                  homeController.addNotInterested(
                    homeController.userId,
                    post.id,
                  );
                  debugPrint(";;;;;;;;;; ${homeController.userId};;;;;;;;");
                },
                onOtherProfileTap: () {
                  print('Navigating to Other Profile with ID: ${post.author?.id}');
                  if (post.author?.id != null) {
                    Get.to(() => OtherProfileView(userId: post.author!.id!));
                  } else {
                    Get.snackbar('Error'.tr, 'User_ID_Not_Available'.tr);
                  }
                },
                postId: post?.id ?? '',
                userName: post?.author?.name ?? 'Unknown'.tr,
                location: post?.location ?? 'Unknown'.tr,
                profileImage: post?.author?.image ?? '',
                images: post!.images,
                description: post.caption ?? '',
                likeCount: post.reactions.length,
                timeAgo: homeController.formatTimeAgo(post.createdAt),
                onAddFriend: () {
                  log("Add Friend clicked for ${post.author?.name}");
                },
                onBookmark: () {
                  print('object');
                  homeController.toggleCollection(post.id!);
                },
                onReaction: () {
                  homeController.toggleLike(post.id!);
                },
              ),
            );
          },
        );
      }),
    );
  }
}