import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/home/views/my_search_view.dart';
import 'package:tails_date/app/modules/home/views/widgets/category_widgets/category_widget.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/stories_section.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/app/modules/notifications/views/notifications_view.dart';
import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
import 'package:tails_date/app/modules/profile/views/other_profile_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../profile/views/profile_view.dart';
import 'category_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.isRegistered<HomeController>()
      ? Get.find()
      : Get.put(HomeController());

  final ProfileController profileController = Get.isRegistered<ProfileController>()
      ? Get.find()
      : Get.put(ProfileController());

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
            'TailsDate'.tr,
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
                  'Categories'.tr,
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
                            name: categoryData.name ?? 'Unknown'.tr,
                            backImage:
                            categoryData.image ?? 'Unknown'.tr,
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
                        onOtherProfileTap: () {
                          final authorId = post.author?.id;
                          final currentUserId = LocalStorage.getData(key: AppConstant.userId);

                          print('Navigating to Other Profile with ID: $authorId');

                          if (authorId != null) {
                            if (authorId != currentUserId) {
                              Get.to(() => OtherProfileView(userId: authorId));
                            } else {
                              Get.to(() => ProfileView(showBackButton: true,));
                            }
                          } else {
                            Get.snackbar('Error'.tr, 'User_ID_Not_Available'.tr);
                          }
                        },
                        postId: post.id ?? '',
                        userName: post.author?.name ?? 'Unknown'.tr,
                        location: post.location ?? 'Unknown'.tr,
                        profileImage: post.author?.image ?? '',
                        images: post.images,
                        description: post.caption ?? '',
                        likeCount: post.reactions.length,
                        timeAgo: homeController.formatTimeAgo(post.createdAt),
                        onAddFriend: () {
                          log("Add Friend clicked for ${post.author?.name}");
                        },
                        onBookmark: () {
                          log("Collection button clicked for post ID: ${post.id}");
                          if (post.id == null || post.id!.isEmpty) {
                            log("Error: Post ID is null or empty");
                            return;
                          }
                          homeController.toggleCollection(post.id!);
                        },
                        onReaction: () {
                          log("Like button clicked for post ID: ${post.id}");
                          if (post.id == null || post.id!.isEmpty) {
                            log("Error: Post ID is null or empty");
                            return;
                          }
                          homeController.toggleLike(post.id!);
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

//
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
// import 'package:tails_date/app/modules/home/views/my_search_view.dart';
// import 'package:tails_date/app/modules/home/views/widgets/category_widgets/category_widget.dart';
// import 'package:tails_date/app/modules/home/views/widgets/home_widgets/stories_section.dart';
// import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
// import 'package:tails_date/app/modules/notifications/views/notifications_view.dart';
// import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
// import 'package:tails_date/app/modules/profile/views/other_profile_view.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/app_images/app_images.dart';
// import 'package:tails_date/common/app_text_style/styles.dart';
//
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../auth_landing/controllers/auth_home_controller.dart';
// import '../../login/views/login_view.dart';
// import 'category_view.dart';
//
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   final HomeController homeController = Get.isRegistered<HomeController>()
//       ? Get.find()
//       : Get.put(HomeController());
//
//   final ProfileController profileController = Get.isRegistered<ProfileController>()
//       ? Get.find()
//       : Get.put(ProfileController());
//
//   final authController = Get.find<AuthHomeController>();
//
//
//   @override
//   void initState() {
//     super.initState();
//     if (!authController.isGuest.value) {
//       profileController.fetchProfile();
//     }
//   }
//
//   void requireLoginDialog() {
//     Get.defaultDialog(
//       title: "Login Required",
//       middleText: "Please log in to use this feature.",
//       textCancel: "Cancel",
//       textConfirm: "Log In",
//       confirmTextColor: Colors.white,
//       onConfirm: () {
//         Get.offAll(() => LoginView());
//       },
//     );
//   }
//
//   bool checkGuest() {
//     if (authController.isGuest.value) {
//       requireLoginDialog();
//       return true; // guest → blocked
//     }
//     return false; // not guest → allowed
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () {
//         return homeController.fetchPosts();
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.mainColor,
//         appBar: AppBar(
//           scrolledUnderElevation: 0,
//           backgroundColor: AppColors.mainColor,
//           title: Text(
//             'TailsDate',
//             style: h2.copyWith(fontWeight: FontWeight.w700),
//           ),
//           automaticallyImplyLeading: false,
//           actions: [
//             GestureDetector(
//               onTap: () {
//                 Get.to(() => MySearchView());
//               },
//               child: Image.asset(
//                 AppImages.search,
//                 scale: 4,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 if (checkGuest()) return; // 🚫 block guest
//                 Get.to(() => NotificationsView());
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 24, right: 16),
//                 child: Image.asset(
//                   AppImages.notification,
//                   scale: 4,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: Obx(() => homeController.isLoading.value
//             ? const Center(
//             child: CircularProgressIndicator(
//               color: AppColors.black,
//             ))
//             : homeController.errorMessage.value.isNotEmpty
//             ? Center(
//             child: Text(homeController.errorMessage.value, style: h5))
//             : SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Stories Section
//               const StoriesSection(),
//               // Categories Section
//               Padding(
//                 padding: const EdgeInsets.only(left: 16, top: 16),
//                 child: Text(
//                   'Categories',
//                   style: h1.copyWith(
//                       fontSize: 20, color: AppColors.black),
//                 ),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Obx(
//                       () => Row(
//                     children: List.generate(
//                       homeController.categories.length + 1,
//                           (index) {
//                         if (index <
//                             homeController.categories.length) {
//                           final categoryData =
//                           homeController.categories[index];
//                           return CategoryWidget(
//                             name: categoryData.name ?? 'Unknown',
//                             backImage:
//                             categoryData.image ?? 'Unknown',
//                             categoryId: categoryData.id,
//                             onTap: () {
//                               if (checkGuest()) return; // 🚫 block guest
//                               Get.to(() => CategoryView(
//                                 categoryName:
//                                 categoryData.name ?? '',
//                                 categoryId: categoryData.id ?? '',
//                               ));
//                               debugPrint(
//                                   'Category Id is : ${categoryData.id}');
//                             },
//                           );
//                         } else {
//                           return const SizedBox(width: 16);
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               // Posts Section
//               Column(
//                 children: List.generate(
//                   homeController.posts.length,
//                       (index) {
//                     final post = homeController.posts[index];
//                     return Padding(
//                         padding: EdgeInsets.only(
//                           bottom:
//                           index == homeController.posts.length - 1
//                               ? 30
//                               : 0,
//                           right: 16,
//                           left: 16,
//                           top: 16,
//                         ),
//                         child: UserPostCard(
//                           isFriend: true,
//                           isLiked: homeController.isPostLiked(post.id ?? ''),
//                           isSaved: homeController.isPostInCollections(post.id ?? ''),
//                           isMe: post.author?.id == LocalStorage.getData(key: AppConstant.userId),
//
//                           onNotInterestedTap: () {
//                             if (checkGuest()) return;
//                             homeController.addNotInterested(
//                               homeController.userId,
//                               post.id,
//                             );
//                           },
//
//                           onOtherProfileTap: () {
//                             if (checkGuest()) return;
//                             Get.to(() => OtherProfileView());
//                             //Get.to(() => OtherProfileView(userId: post.author?.id));
//                           },
//
//                           postId: post.id ?? '',
//                           userName: post.author?.name ?? 'Unknown',
//                           location: post.location ?? 'Unknown',
//                           profileImage: post.author?.image ?? '',
//                           images: post.images,
//                           description: post.caption ?? '',
//                           likeCount: post.reactions.length,
//                           timeAgo: homeController.formatTimeAgo(post.createdAt),
//
//                           onAddFriend: () {
//                             if (checkGuest()) return; // 🚫 block guest
//                             log("Add Friend clicked for ${post.author?.name}");
//                             // your API call here
//                           },
//
//                           onBookmark: () {
//                             if (checkGuest()) return; // 🚫 block guest
//                             if (post.id == null || post.id!.isEmpty) {
//                               log("Error: Post ID is null or empty");
//                               return;
//                             }
//                             homeController.toggleCollection(post.id!);
//                           },
//
//                           onReaction: () {
//                             if (checkGuest()) return; // 🚫 block guest
//                             if (post.id == null || post.id!.isEmpty) {
//                               log("Error: Post ID is null or empty");
//                               return;
//                             }
//                             homeController.toggleLike(post.id!);
//                           },
//                         )
//
//                       // UserPostCard(
//                       //   isFriend: true,
//                       //   isLiked: homeController.isPostLiked(post.id ?? ''),
//                       //   isSaved: homeController.isPostInCollections(post.id ?? ''),
//                       //   isMe: post.author?.id == LocalStorage.getData(key: AppConstant.userId),
//                       //   onNotInterestedTap: () {
//                       //     homeController.addNotInterested(
//                       //       homeController.userId,
//                       //       post.id,
//                       //     );
//                       //     debugPrint(";;;;;;;;;; ${homeController.userId};;;;;;;;");
//                       //   },
//                       //   onOtherProfileTap: () {
//                       //     print('Other Profile');
//                       //     Get.to(() => OtherProfileView());
//                       //   },
//                       //   postId: post.id ?? '',
//                       //   userName: post.author?.name ?? 'Unknown',
//                       //   location: post.location ?? 'Unknown',
//                       //   profileImage: post.author?.image ?? '',
//                       //   images: post.images,
//                       //   description: post.caption ?? '',
//                       //   likeCount: post.reactions.length,
//                       //   timeAgo: homeController.formatTimeAgo(post.createdAt),
//                       //   onBookmark: () {
//                       //     if (checkGuest()) return;
//                       //     homeController.toggleCollection(post.id!);
//                       //   },
//                       //   onReaction: () {
//                       //     if (checkGuest()) return;
//                       //     homeController.toggleLike(post.id!);
//                       //   },
//                       //   onAddFriend: () {
//                       //     if (checkGuest()) return;
//                       //     log("Add Friend clicked for ${post.author?.name}");
//                       //   },
//                       //
//                       //   // onAddFriend: () {
//                       //   //   log("Add Friend clicked for ${post.author?.name}");
//                       //   // },
//                       //   // onBookmark: () {
//                       //   //   log("Collection button clicked for post ID: ${post.id}");
//                       //   //   if (post.id == null || post.id!.isEmpty) {
//                       //   //     log("Error: Post ID is null or empty");
//                       //   //     return;
//                       //   //   }
//                       //   //   homeController.toggleCollection(post.id!);
//                       //   // },
//                       //   // onReaction: () {
//                       //   //   log("Like button clicked for post ID: ${post.id}");
//                       //   //   if (post.id == null || post.id!.isEmpty) {
//                       //   //     log("Error: Post ID is null or empty");
//                       //   //     return;
//                       //   //   }
//                       //   //   homeController.toggleLike(post.id!);
//                       //   // },
//                       // ),
//
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }
