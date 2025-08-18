import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/local_store.dart';
import '../../profile/controllers/collections_controller.dart';
import '../../profile/views/other_profile_view.dart';

class CategoryView extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  const CategoryView(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final HomeController homeController = Get.find<HomeController>();
  final CollectionsController collectionsController =
      Get.put(CollectionsController());

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      homeController.fetchCategoryPosts(categoryId: widget.categoryId);
    });
    collectionsController.fetchCollections();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.black,
            ),
          );
        }
        if (homeController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  homeController.errorMessage.value,
                  style: const TextStyle(color: AppColors.orange),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    homeController.fetchCategoryPosts(
                        categoryId: widget.categoryId);
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        if (homeController.categoryWisePost.isEmpty) {
          return const Center(child: Text('No posts available'));
        }
        return ListView.builder(
          itemCount: homeController.categoryWisePost.length,
          itemBuilder: (context, index) {
            final post = homeController.categoryWisePost[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == homeController.categoryWisePost.length - 1
                    ? 30
                    : 0,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: UserPostCard(
                isFriend: true,
                isLiked: homeController.isPostLiked(post.id ?? ''),
                isSaved: homeController.isPostInCollections(post.id ?? ''),
                isMe: post.author?.id == LocalStorage.getData(key: AppConstant.userId),
                onNotInterestedTap: () {
                  homeController.addNotInterested(
                    homeController.userId,
                    post.id,
                  );
                  debugPrint(";;;;;;;;;; ${homeController.userId};;;;;;;;");
                },
                onOtherProfileTap: (){
                  Get.to(()=> OtherProfileView());
                },
                postId: post.id ?? '',
                userName: post.author?.name ?? 'Unknown',
                location: post.location ?? 'Unknown',
                profileImage: post.author?.image ?? '',
                images: post.images,
                description: post.caption ?? '',
                likeCount: post.reactions.length,
                timeAgo: homeController.formatTimeAgo(post.createdAt),
                onAddFriend: () {
                  log("Add Friend clicked for ${post.author?.name}");
                },
                onBookmark: () {
                  if (post.id == null || post.id!.isEmpty) {
                    log("Error: Post ID is null or empty");
                    return;
                  }
                  homeController.toggleCollection(post.id!);
                  //collectionsController.addOrRemoveCollection(post.id!);
                },
                onReaction: () {
                  if (post.id == null || post.id!.isEmpty) {
                    log("Error: Post ID is null or empty");
                    return;
                  }
                  homeController.addOrRemoveReaction(post.id!);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
