import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
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
        title: const Text('Collections'),
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
          return const Center(
            child: Text(
              'No collections found',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.collections.length,
          itemBuilder: (context, index) {
            final collection = controller.collections[index];
            final post = collection.post;
            return UserPostCard(
              onOtherProfileTap: (){
                Get.to(()=> OtherProfileView());
              },
              postId: post?.id ?? '',
              userName: post?.author?.name ?? 'Unknown',
              location: post?.location ?? 'Unknown',
              profileImage: post?.author?.image ?? '',
              images: post!.images,
              description: post.caption ?? '',
              likeCount: post.reactions.length,
              timeAgo: homeController.formatTimeAgo(post.createdAt),
              onAddFriend: () {
                log("Add Friend clicked for ${post.author?.name}");
              },
              onBookmark: (){
                print('object');
                controller.addOrRemoveCollection(post.id!);
              },
              onReaction: () {
                homeController.addOrRemoveReaction(post.id!);
              },
            );
          },
        );
      }),
    );
  }
}