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
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../profile/views/profile_view.dart';
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
//   @override
//   void initState() {
//     super.initState();
//     profileController.fetchProfile();
//   }
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
//             'TailsDate'.tr,
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
//                   'Categories'.tr,
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
//                             name: categoryData.name ?? 'Unknown'.tr,
//                             backImage:
//                             categoryData.image ?? 'Unknown'.tr,
//                             categoryId: categoryData.id,
//                             onTap: () {
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
//                       padding: EdgeInsets.only(
//                         bottom:
//                         index == homeController.posts.length - 1
//                             ? 30
//                             : 0,
//                         right: 16,
//                         left: 16,
//                         top: 16,
//                       ),
//                       child: UserPostCard(
//                         isFriend: true,
//                         isLiked: homeController.isPostLiked(post.id ?? ''),
//                         isSaved: homeController.isPostInCollections(post.id ?? ''),
//                         isMe: post.author?.id == LocalStorage.getData(key: AppConstant.userId),
//                         onNotInterestedTap: () {
//                           homeController.addNotInterested(
//                             homeController.userId,
//                             post.id,
//                           );
//                           debugPrint(";;;;;;;;;; ${homeController.userId};;;;;;;;");
//                         },
//                         onOtherProfileTap: () {
//                           final authorId = post.author?.id;
//                           final currentUserId = LocalStorage.getData(key: AppConstant.userId);
//
//                           print('Navigating to Other Profile with ID: $authorId');
//
//                           if (authorId != null) {
//                             if (authorId != currentUserId) {
//                               Get.to(() => OtherProfileView(userId: authorId));
//                             } else {
//                               Get.to(() => ProfileView(showBackButton: true,));
//                             }
//                           } else {
//                             Get.snackbar('Error'.tr, 'User_ID_Not_Available'.tr);
//                           }
//                         },
//                         postId: post.id ?? '',
//                         userName: post.author?.name ?? 'Unknown'.tr,
//                         location: post.location ?? 'Unknown'.tr,
//                         profileImage: post.author?.image ?? '',
//                         images: post.images,
//                         description: post.caption ?? '',
//                         likeCount: post.reactions.length,
//                         timeAgo: homeController.formatTimeAgo(post.createdAt),
//                         onAddFriend: () {
//                           log("Add Friend clicked for ${post.author?.name}");
//                         },
//                         onBookmark: () {
//                           log("Collection button clicked for post ID: ${post.id}");
//                           if (post.id == null || post.id!.isEmpty) {
//                             log("Error: Post ID is null or empty");
//                             return;
//                           }
//                           homeController.toggleCollection(post.id!);
//                         },
//                         onReaction: () {
//                           log("Like button clicked for post ID: ${post.id}");
//                           if (post.id == null || post.id!.isEmpty) {
//                             log("Error: Post ID is null or empty");
//                             return;
//                           }
//                           homeController.toggleLike(post.id!);
//                         },
//                       ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/home/views/my_search_view.dart';
import 'package:tails_date/app/modules/home/views/widgets/category_widgets/category_widget.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/stories_section.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:tails_date/app/modules/notifications/views/notifications_view.dart';
import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
import 'package:tails_date/app/modules/profile/views/other_profile_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
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

  final ProfileController profileController =
      Get.isRegistered<ProfileController>()
          ? Get.find()
          : Get.put(ProfileController());

  final NotificationsController notificationsController =
      Get.isRegistered<NotificationsController>()
          ? Get.find()
          : Get.put(NotificationsController());

  @override
  void initState() {
    super.initState();
    homeController.fetchPosts();
    homeController.fetchMyPosts();
    profileController.fetchProfile();
    notificationsController.fetchFriendSuggestions();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await homeController.fetchPosts();
        await notificationsController.fetchFriendSuggestions();
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
              child: Image.asset(AppImages.search, scale: 4),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => NotificationsView());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 16),
                child: Image.asset(AppImages.notification, scale: 4),
              ),
            ),
          ],
        ),
        body: Obx(() {
          if (homeController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.black),
            );
          } else if (homeController.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text(homeController.errorMessage.value, style: h5),
            );
          } else {
            return SingleChildScrollView(
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
                      style: h1.copyWith(fontSize: 20, color: AppColors.black),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(() => Row(
                          children: List.generate(
                            homeController.categories.length + 1,
                            (index) {
                              if (index < homeController.categories.length) {
                                final categoryData =
                                    homeController.categories[index];
                                return CategoryWidget(
                                  name: categoryData.name ?? 'Unknown'.tr,
                                  backImage: categoryData.image ?? 'Unknown'.tr,
                                  categoryId: categoryData.id,
                                  onTap: () {
                                    Get.to(() => CategoryView(
                                          categoryName: categoryData.name ?? '',
                                          categoryId: categoryData.id ?? '',
                                        ));
                                  },
                                );
                              } else {
                                return const SizedBox(width: 16);
                              }
                            },
                          ),
                        )),
                  ),

                  // Friend Suggestions Section (only show when NO posts)
                  Obx(() {
                    if (homeController.posts.isNotEmpty) {
                      return const SizedBox.shrink();   // 🔥 Hide suggestions if posts exist
                    }

                    if (notificationsController.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.black),
                      );
                    }
                    else if (notificationsController.errorMessage.value.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(notificationsController.errorMessage.value, style: h5),
                      );
                    }
                    else if (notificationsController.filteredFriendsSuggestionList.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              'Friend Suggestions',
                              style: h1.copyWith(fontSize: 20, color: AppColors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              'Add Some Friends To See Posts From Them',
                              style: h4.copyWith(color: AppColors.black),
                            ),
                          ),
                          sh8,
                          SizedBox(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              children: notificationsController.filteredFriendsSuggestionList
                                  .map((friend) {
                                return Container(
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 12),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(friend.image ?? ''),
                                      ),
                                      sh5,
                                      Text(
                                        friend.name ?? 'Unknown'.tr,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: h5,
                                      ),
                                      sh5,
                                      CustomButton(
                                        text: 'Add'.tr,
                                        width: 80,
                                        height: 28,
                                        backgroundColor: AppColors.black,
                                        onPressed: () {
                                          notificationsController.sendFriendRequest(friend.id ?? '');
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }
                    else {
                      return const SizedBox.shrink();
                    }
                  }),


                  // Posts Section
                  Column(
                    children:
                        List.generate(homeController.posts.length, (index) {
                      final post = homeController.posts[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              index == homeController.posts.length - 1 ? 30 : 0,
                          right: 16,
                          left: 16,
                          top: 16,
                        ),
                        child: UserPostCard(
                          isFriend: true,
                          isLiked: homeController.isPostLiked(post.id ?? ''),
                          isSaved:
                              homeController.isPostInCollections(post.id ?? ''),
                          isMe: post.author?.id ==
                              LocalStorage.getData(key: AppConstant.userId),
                          onNotInterestedTap: () {
                            homeController.addNotInterested(
                                homeController.userId, post.id);
                          },
                          onOtherProfileTap: () {
                            final authorId = post.author?.id;
                            final currentUserId =
                                LocalStorage.getData(key: AppConstant.userId);

                            if (authorId != null) {
                              if (authorId != currentUserId) {
                                Get.to(
                                    () => OtherProfileView(userId: authorId));
                              } else {
                                Get.to(() => ProfileView(showBackButton: true));
                              }
                            } else {
                              Get.snackbar(
                                  'Error'.tr, 'User_ID_Not_Available'.tr);
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
                          onAddFriend: () {},
                          onBookmark: () {
                            if (post.id != null && post.id!.isNotEmpty) {
                              homeController.toggleCollection(post.id!);
                            }
                          },
                          onReaction: () {
                            if (post.id != null && post.id!.isNotEmpty) {
                              homeController.toggleLike(post.id!);
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
