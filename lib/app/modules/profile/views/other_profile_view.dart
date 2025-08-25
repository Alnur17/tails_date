// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:tails_date/app/modules/chats/views/message_view.dart';
// import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
// import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
// import 'package:tails_date/app/modules/profile/views/friends_view.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/size_box/custom_sizebox.dart';
// import 'package:tails_date/common/app_images/app_images.dart';
// import 'package:tails_date/common/app_text_style/styles.dart';
// import 'package:tails_date/common/widgets/custom_button.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
//
// class OtherProfileView extends StatefulWidget {
//   final String userId;
//
//   const OtherProfileView({super.key, required this.userId});
//
//   @override
//   State<OtherProfileView> createState() => _OtherProfileViewState();
// }
//
// class _OtherProfileViewState extends State<OtherProfileView> {
//   bool showPosts = true;
//   bool showVideo = false;
//   bool showPetGallery = false;
//   bool showOwnerGallery = false;
//
//   final ProfileController profileController = Get.find<ProfileController>();
//   final HomeController homeController = Get.find<HomeController>();
//
//   @override
//   void initState() {
//     super.initState();
//     profileController
//         .fetchOtherProfile(widget.userId); // Fetch other user's profile
//     //homeController.fetchPostsByUserId(widget.userId);
//   }
//
//   Future<dynamic> generateThumbnail(String videoUrl) async {
//     try {
//       final tempDir = await getTemporaryDirectory();
//       final thumbnailPath = await VideoThumbnail.thumbnailFile(
//         video: videoUrl,
//         thumbnailPath: tempDir.path,
//         imageFormat: ImageFormat.JPEG,
//         maxHeight: 200,
//         quality: 75,
//       );
//       return thumbnailPath;
//     } catch (e) {
//       print("Thumbnail generation error: $e");
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: Text('User_Profile'.tr), // Updated to use translation
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Image.asset(
//             AppImages.back,
//             scale: 4,
//           ),
//         ),
//       ),
//       body: Obx(
//             () => profileController.isOtherProfileLoading.value ||
//             homeController.isLoading.value
//             ? const Center(
//           child: CircularProgressIndicator(
//             color: AppColors.black,
//           ),
//         )
//             : profileController.otherProfileData.value == null
//             ? Center(child: Text('Failed_To_Load_User_Profile'.tr)) // Updated to use translation
//             : SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Container(
//                       height: 200,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: profileController.otherProfileData
//                               .value!.data?.coverImage !=
//                               null
//                               ? NetworkImage(profileController
//                               .otherProfileData
//                               .value!
//                               .data!
//                               .coverImage!)
//                               : const AssetImage(
//                               AppImages.groupOfDogs)
//                           as ImageProvider,
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: -50,
//                       left: 12,
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: profileController
//                             .otherProfileData
//                             .value!
//                             .data
//                             ?.image !=
//                             null
//                             ? NetworkImage(profileController
//                             .otherProfileData.value!.data!.image!)
//                             : const AssetImage(AppImages.profileImage)
//                         as ImageProvider,
//                       ),
//                     ),
//                   ],
//                 ),
//                 sh60,
//                 // Profile info
//                 Text(
//                   profileController
//                       .otherProfileData.value!.data?.name ??
//                       'Unknown',
//                   style: h2.copyWith(fontSize: 20),
//                 ),
//                 sh12,
//                 Row(
//                   children: [
//                     Image.asset(
//                       AppImages.location,
//                       scale: 4,
//                     ),
//                     sw8,
//                     Text(
//                       profileController.otherProfileData.value!.data
//                           ?.location ??
//                           'Location_Not_Set'.tr, // Updated to use translation
//                       style: h4,
//                     ),
//                   ],
//                 ),
//                 sh16,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: CustomButton(
//                         height: 40,
//                         onPressed: () {
//                           Get.to(() => FriendsView());
//                         },
//                         text: 'Friends'.tr, // Updated to use translation
//                         backgroundColor: AppColors.white,
//                         borderColor: AppColors.black,
//                         textStyle:
//                         h3.copyWith(color: AppColors.black),
//                       ),
//                     ),
//                     sw12,
//                     Expanded(
//                       child: CustomButton(
//                         height: 40,
//                         onPressed: () {
//                           Get.to(() => MessageView());
//                         },
//                         text: 'Message'.tr, // Updated to use translation
//                       ),
//                     ),
//                   ],
//                 ),
//                 sh20,
//                 // Attributes
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: AttributeTile(
//                         label: 'Gender'.tr, // Updated to use translation
//                         value: profileController.otherProfileData
//                             .value!.data?.gender ??
//                             'Not_Available'.tr, // Updated to use translation
//                       ),
//                     ),
//                     sw12,
//                     Expanded(
//                       child: AttributeTile(
//                         label: 'Age'.tr, // Updated to use translation
//                         value: profileController
//                             .otherProfileData.value!.data?.age
//                             ?.toString() ??
//                             'Not_Available'.tr, // Updated to use translation
//                       ),
//                     ),
//                     sw12,
//                     Expanded(
//                       child: AttributeTile(
//                         label: 'Category'.tr, // Updated to use translation
//                         value: profileController.otherProfileData
//                             .value!.data?.category ??
//                             'Not_Available'.tr, // Updated to use translation
//                       ),
//                     ),
//                   ],
//                 ),
//                 sh20,
//                 // Pet info
//                 Text(
//                   'Pet_Info'.tr, // Updated to use translation
//                   style: h2.copyWith(fontSize: 18),
//                 ),
//                 sh8,
//                 Text(
//                   profileController
//                       .otherProfileData.value!.data?.petInfo ??
//                       'Not_Available'.tr, // Updated to use translation
//                   style: h4,
//                 ),
//                 sh16,
//                 // Pet Owner Info
//                 Text(
//                   'Pet_Owner'.tr, // Updated to use translation
//                   style: h3,
//                 ),
//                 sh12,
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   decoration: BoxDecoration(
//                     color: AppColors.fillColorTwo,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: ListTile(
//                     contentPadding: EdgeInsets.zero,
//                     leading: CircleAvatar(
//                       radius: 30,
//                       backgroundImage: profileController
//                           .otherProfileData
//                           .value!
//                           .data
//                           ?.ownerImage !=
//                           null
//                           ? NetworkImage(profileController
//                           .otherProfileData
//                           .value!
//                           .data!
//                           .ownerImage!)
//                           : null,
//                     ),
//                     title: Text(
//                       profileController.otherProfileData.value!.data
//                           ?.ownerName ??
//                           'Unknown',
//                       style: h4,
//                     ),
//                     subtitle: Text(
//                       '${profileController.otherProfileData.value!.data?.ownerRelationshipStatus ?? 'Not_Available'.tr}, ${profileController.otherProfileData.value!.data?.ownerGender ?? 'Not_Available'.tr}', // Updated to use translation
//                       style: h6,
//                     ),
//                   ),
//                 ),
//                 sh16,
//                 // Posts and Collections Toggle
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AttributeTile extends StatelessWidget {
//   final String label;
//   final String value;
//
//   const AttributeTile({super.key, required this.label, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.secondaryOrangeColor),
//         color: AppColors.fillColorTwo,
//       ),
//       child: Column(
//         children: [
//           Text(
//             label,
//             style: h4.copyWith(color: AppColors.secondaryOrangeColor),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             value,
//             style: h4.copyWith(color: AppColors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tails_date/app/modules/chats/views/message_view.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
import 'package:tails_date/app/modules/profile/views/friends_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../home/views/widgets/home_widgets/user_post_card.dart';
import 'my_reels_view.dart';

class OtherProfileView extends StatefulWidget {
  final String userId;

  const OtherProfileView({super.key, required this.userId});

  @override
  State<OtherProfileView> createState() => _OtherProfileViewState();
}

class _OtherProfileViewState extends State<OtherProfileView> {
  bool showPosts = true;
  bool showVideo = false;
  bool showPetGallery = false;
  bool showOwnerGallery = false;

  final ProfileController profileController = Get.find<ProfileController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      profileController.fetchOtherProfile(widget.userId);
      profileController.fetchOtherReelsByUserId(widget.userId);
      homeController.fetchPostsByUserId(widget.userId);
    });
  }

  Future<dynamic> generateThumbnail(String videoUrl) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 200,
        quality: 75,
      );
      return thumbnailPath;
    } catch (e) {
      print("Thumbnail generation error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Profile'.tr), // Updated to use translation
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
      body: Obx(
            () => profileController.isOtherProfileLoading.value ||
            homeController.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(
            color: AppColors.black,
          ),
        )
            : profileController.otherProfileData.value == null
            ? Center(child: Text('Failed_To_Load_User_Profile'.tr)) // Updated to use translation
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: profileController.otherProfileData
                              .value!.data?.coverImage !=
                              null
                              ? NetworkImage(profileController
                              .otherProfileData
                              .value!
                              .data!
                              .coverImage!)
                              : const AssetImage(
                              AppImages.groupOfDogs)
                          as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      left: 12,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profileController
                            .otherProfileData
                            .value!
                            .data
                            ?.image !=
                            null
                            ? NetworkImage(profileController
                            .otherProfileData.value!.data!.image!)
                            : const AssetImage(AppImages.profileImage)
                        as ImageProvider,
                      ),
                    ),
                  ],
                ),
                sh60,
                // Profile info
                Text(
                  profileController
                      .otherProfileData.value!.data?.name ??
                      'Unknown',
                  style: h2.copyWith(fontSize: 20),
                ),
                sh12,
                Row(
                  children: [
                    Image.asset(
                      AppImages.location,
                      scale: 4,
                    ),
                    sw8,
                    Text(
                      profileController.otherProfileData.value!.data
                          ?.location ??
                          'Location_Not_Set'.tr, // Updated to use translation
                      style: h4,
                    ),
                  ],
                ),
                sh16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        onPressed: () {
                          Get.to(() => FriendsView());
                        },
                        text: 'Friends'.tr, // Updated to use translation
                        backgroundColor: AppColors.white,
                        borderColor: AppColors.black,
                        textStyle:
                        h3.copyWith(color: AppColors.black),
                      ),
                    ),
                    sw12,
                    Expanded(
                      child: CustomButton(
                        height: 40,
                        onPressed: () {
                          Get.to(() => MessageView());
                        },
                        text: 'Message'.tr, // Updated to use translation
                      ),
                    ),
                  ],
                ),
                sh20,
                // Attributes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AttributeTile(
                        label: 'Gender'.tr, // Updated to use translation
                        value: profileController.otherProfileData
                            .value!.data?.gender ??
                            'Not_Available'.tr, // Updated to use translation
                      ),
                    ),
                    sw12,
                    Expanded(
                      child: AttributeTile(
                        label: 'Age'.tr, // Updated to use translation
                        value: profileController
                            .otherProfileData.value!.data?.age
                            ?.toString() ??
                            'Not_Available'.tr, // Updated to use translation
                      ),
                    ),
                    sw12,
                    Expanded(
                      child: AttributeTile(
                        label: 'Category'.tr, // Updated to use translation
                        value: profileController.otherProfileData
                            .value!.data?.category ??
                            'Not_Available'.tr, // Updated to use translation
                      ),
                    ),
                  ],
                ),
                sh20,
                // Pet info
                Text(
                  'Pet_Info'.tr, // Updated to use translation
                  style: h2.copyWith(fontSize: 18),
                ),
                sh8,
                Text(
                  profileController
                      .otherProfileData.value!.data?.petInfo ??
                      'Not_Available'.tr, // Updated to use translation
                  style: h4,
                ),
                sh16,
                // Pet Owner Info
                Text(
                  'Pet_Owner'.tr, // Updated to use translation
                  style: h3,
                ),
                sh12,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColors.fillColorTwo,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: profileController
                          .otherProfileData
                          .value!
                          .data
                          ?.ownerImage !=
                          null
                          ? NetworkImage(profileController
                          .otherProfileData
                          .value!
                          .data!
                          .ownerImage!)
                          : null,
                    ),
                    title: Text(
                      profileController.otherProfileData.value!.data
                          ?.ownerName ??
                          'Unknown',
                      style: h4,
                    ),
                    subtitle: Text(
                      '${profileController.otherProfileData.value!.data?.ownerRelationshipStatus ?? 'Not_Available'.tr}, ${profileController.otherProfileData.value!.data?.ownerGender ?? 'Not_Available'.tr}', // Updated to use translation
                      style: h6,
                    ),
                  ),
                ),
                sh16,
                // Posts and Collections Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Post'.tr,
                        onPressed: () {
                          setState(() {
                            showPosts = true;
                            showVideo = false;
                            showPetGallery = false;
                            showOwnerGallery = false;
                          });
                        },
                        textStyle: h6.copyWith(
                            color: showPosts
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.bold),
                        backgroundColor: showPosts
                            ? AppColors.black
                            : AppColors.transparent,
                      ),
                    ),
                    sw12,
                    Expanded(
                      child: CustomButton(
                        text: 'Video'.tr,
                        onPressed: () {
                          setState(() {
                            showPosts = false;
                            showVideo = true;
                            showPetGallery = false;
                            showOwnerGallery = false;
                          });
                        },
                        textStyle: h6.copyWith(
                            color: showVideo
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.bold),
                        backgroundColor: showVideo
                            ? AppColors.black
                            : AppColors.transparent,
                      ),
                    ),
                    sw12,
                    Expanded(
                      child: CustomButton(
                        text: 'Pet_Gallery'.tr,
                        onPressed: () {
                          setState(() {
                            showPosts = false;
                            showVideo = false;
                            showPetGallery = true;
                            showOwnerGallery = false;
                          });
                        },
                        textStyle: h6.copyWith(
                            color: showPetGallery
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.bold),
                        backgroundColor: showPetGallery
                            ? AppColors.black
                            : AppColors.transparent,
                      ),
                    ),
                    sw12,
                    Expanded(
                      child: CustomButton(
                        text: 'Owner_Gallery'.tr,
                        onPressed: () {
                          setState(() {
                            showPosts = false;
                            showVideo = false;
                            showPetGallery = false;
                            showOwnerGallery = true;
                          });
                        },
                        textStyle: h6.copyWith(
                            color: showOwnerGallery
                                ? AppColors.white
                                : AppColors.black,
                            fontWeight: FontWeight.bold),
                        backgroundColor: showOwnerGallery
                            ? AppColors.black
                            : AppColors.transparent,
                      ),
                    ),
                  ],
                ),
                sh20,
                // Posts or Collections
                if (showPosts)
                  homeController.otherUserPosts.isEmpty
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32),
                      child: Image.asset(AppImages.profileBack,
                          scale: 4),
                    ),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemCount: homeController.otherUserPosts.length,
                    itemBuilder: (context, index) {
                      final post =
                      homeController.otherUserPosts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8),
                        child: UserPostCard(
                          isFriend: true,
                          isLiked: homeController
                              .isPostLiked(post.id ?? ''),
                          isSaved: homeController
                              .isPostInCollections(
                              post.id ?? ''),
                          isMe: post.author?.id == LocalStorage.getData(
                              key: AppConstant.userId),
                          // onNotInterestedTap: () {
                          //   homeController.addNotInterested(
                          //     homeController.userId,
                          //     post.id,
                          //   );
                          //   debugPrint(
                          //       ";;;;;;;;;; ${homeController.userId};;;;;;;;");
                          // },
                          onOtherProfileTap: () {},
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
                            homeController
                                .toggleCollection(post.id!);
                          },
                          onReaction: () {
                            homeController.toggleLike(post.id!);
                          },
                        ),
                      );
                    },
                  )
                else if (showVideo)
                  profileController.otherReelsData.isEmpty
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32),
                      child: Image.asset(
                        AppImages.profileBack,
                        scale: 4,
                      ),
                    ),
                  )
                      : GridView.builder(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount:
                    profileController.otherReelsData.length,
                    itemBuilder: (context, index) {
                      final reel =
                      profileController.otherReelsData[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() =>
                              MyReelsView(initialReel: reel));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(12),
                            color: AppColors.white,
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  child: FutureBuilder<dynamic>(
                                    future: generateThumbnail(
                                        reel.video ?? ''),
                                    builder:
                                        (context, snapshot) {
                                      if (snapshot
                                          .connectionState ==
                                          ConnectionState
                                              .waiting) {
                                        return const Center(
                                          child:
                                          CircularProgressIndicator(
                                            color:
                                            AppColors.black,
                                          ),
                                        );
                                      } else if (snapshot
                                          .hasError ||
                                          snapshot.data ==
                                              null) {
                                        return Image.asset(
                                          AppImages.notFound,
                                          fit: BoxFit.cover,
                                        );
                                      } else {
                                        return Image.file(
                                          File(snapshot.data),
                                          fit: BoxFit.cover,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                child: Image.asset(
                                  AppImages.playSmall,
                                  scale: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                else if (showPetGallery)
                    (profileController.otherProfileData.value!.data
                        ?.gallery.isEmpty ??
                        true)
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32),
                      child: Center(
                        child: Image.asset(
                            AppImages.profileBack,
                            scale: 4),
                      ),
                    )
                        : GridView.builder(
                      padding: const EdgeInsets.only(top: 12),
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: profileController.otherProfileData
                          .value!.data?.gallery.length ??
                          0,
                      itemBuilder: (context, index) {
                        final imagePath = profileController
                            .otherProfileData
                            .value!
                            .data!
                            .gallery[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(12),
                            color: AppColors.white,
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(
                                      12),
                                  child: Image.network(
                                    profileController
                                        .otherProfileData
                                        .value!
                                        .data!
                                        .gallery[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    profileController
                                        .patchRemovePetGalleryImage(
                                        imagePath);
                                  },
                                  child: Container(
                                    padding:
                                    EdgeInsets.all(6),
                                    decoration:
                                    ShapeDecoration(
                                      shape: CircleBorder(),
                                      color: AppColors.white,
                                    ),
                                    child: Image.asset(
                                      AppImages.close,
                                      scale: 4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  else if (showOwnerGallery)
                      (profileController.otherProfileData.value!.data
                          ?.ownerGallery.isEmpty ??
                          true)
                          ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32),
                        child: Center(
                          child: Image.asset(
                              AppImages.profileBack,
                              scale: 4),
                        ),
                      )
                          : GridView.builder(
                        padding: const EdgeInsets.only(top: 12),
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: profileController
                            .otherProfileData
                            .value!
                            .data
                            ?.ownerGallery
                            .length ??
                            0,
                        itemBuilder: (context, index) {
                          final imagePath = profileController
                              .otherProfileData
                              .value!
                              .data!
                              .ownerGallery[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(12),
                              color: AppColors.white,
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(
                                        12),
                                    child: Image.network(
                                      profileController
                                          .otherProfileData
                                          .value!
                                          .data!
                                          .ownerGallery[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: GestureDetector(
                                    onTap: () {
                                      profileController
                                          .patchRemoveOwnerGalleryImage(
                                          imagePath);
                                    },
                                    child: Container(
                                      padding:
                                      EdgeInsets.all(6),
                                      decoration:
                                      ShapeDecoration(
                                        shape: CircleBorder(),
                                        color: AppColors.white,
                                      ),
                                      child: Image.asset(
                                        AppImages.close,
                                        scale: 4,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                sh20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AttributeTile extends StatelessWidget {
  final String label;
  final String value;

  const AttributeTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondaryOrangeColor),
        color: AppColors.fillColorTwo,
      ),
      child: Column(
        children: [
          Text(
            label.tr,
            style: h4.copyWith(color: AppColors.secondaryOrangeColor),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: h4.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }
}