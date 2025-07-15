import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tails_date/app/data/dummy_data.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
import 'package:tails_date/app/modules/profile/views/edit_post_view.dart';
import 'package:tails_date/app/modules/profile/views/edit_profile_view.dart';
import 'package:tails_date/app/modules/profile/views/friends_view.dart';
import 'package:tails_date/app/modules/profile/views/my_reels_view.dart';
import 'package:tails_date/app/modules/profile/views/profile_setting_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_popup_menu_button.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool showPosts = true;
  bool showVideo = false;
  bool showPetGallery = false;
  bool showOwnerGallery = false;

  final ProfileController controller = Get.put(ProfileController());

  Future<dynamic> generateThumbnail(String videoUrl) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 200, // Set desired height
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
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProfileSettingView(
                    profileImage:
                        controller.profileData.value!.data?.image ?? '',
                    name: controller.profileData.value!.data?.name ?? 'N/A',
                    location: controller.profileData.value!.data?.location ??
                        'Location not set',
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.asset(
                AppImages.settings,
                scale: 4,
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.profileData.value == null
                ? const Center(child: Text('Failed to load profile'))
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
                                    image: NetworkImage(
                                      controller.profileData.value!.data
                                              ?.coverImage ??
                                          AppImages.groupOfDogs,
                                    ),
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
                                  backgroundImage: NetworkImage(controller
                                          .profileData.value!.data?.image ??
                                      AppImages.profileImage),
                                ),
                              ),
                            ],
                          ),
                          sh60,
                          // Profile info
                          Text(
                            controller.profileData.value!.data?.name ??
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
                                controller.profileData.value!.data?.location ??
                                    'Location not set',
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
                                    Get.to(() =>
                                        //FriendsView(data: DummyData.friends),
                                      FriendsView()
                                        );
                                  },
                                  //text: '${DummyData.friends.length} Friends',
                                  text: '${controller.profileData.value?.data?.totalFriends} Friends',
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
                                    Get.to(() => EditProfileView());
                                  },
                                  text: 'Edit Profile',
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
                                  label: 'Gender',
                                  value: controller
                                          .profileData.value!.data?.gender ??
                                      'N/A',
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: AttributeTile(
                                  label: 'Age',
                                  value: controller.profileData.value!.data?.age
                                          ?.toString() ??
                                      'N/A',
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: AttributeTile(
                                  label: 'Category',
                                  value: controller
                                          .profileData.value!.data?.category ??
                                      'N/A',
                                ),
                              ),
                            ],
                          ),
                          sh20,
                          // Pet info
                          Text(
                            'Pet info',
                            style: h2.copyWith(fontSize: 18),
                          ),
                          sh8,
                          Text(
                            controller.profileData.value!.data?.petInfo ??
                                'N/A',
                            style: h4,
                          ),
                          sh16,
                          // Pet Owner Info
                          Text(
                            'Pet Owner',
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
                                backgroundImage: NetworkImage(
                                  controller.profileData.value!.data
                                          ?.ownerImage ??
                                      AppImages.profileImageTwo,
                                ),
                              ),
                              title: Text(
                                controller.profileData.value!.data?.ownerName ??
                                    'Unknown',
                                style: h4,
                              ),
                              subtitle: Text(
                                '${controller.profileData.value!.data?.ownerRelationshipStatus ?? 'N/A'}, ${controller.profileData.value!.data?.ownerGender ?? 'N/A'}',
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
                                  text: 'Post',
                                  onPressed: () {
                                    setState(() {
                                      showPosts = true;
                                      showVideo = false;
                                      showPetGallery = false;
                                      showOwnerGallery = false;
                                    });
                                  },
                                  textStyle: h3.copyWith(
                                    color: showPosts
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                  backgroundColor: showPosts
                                      ? AppColors.black
                                      : AppColors.transparent,
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: CustomButton(
                                  text: 'Video',
                                  onPressed: () {
                                    setState(() {
                                      showPosts = false;
                                      showVideo = true;
                                      showPetGallery = false;
                                      showOwnerGallery = false;
                                    });
                                  },
                                  textStyle: h3.copyWith(
                                    color: showVideo
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                  backgroundColor: showVideo
                                      ? AppColors.black
                                      : AppColors.transparent,
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: CustomButton(
                                  text: 'Pet\nGallery',
                                  onPressed: () {
                                    setState(() {
                                      showPosts = false;
                                      showVideo = false;
                                      showPetGallery = true;
                                      showOwnerGallery = false;
                                    });
                                  },
                                  textStyle: h3.copyWith(
                                    color: showPetGallery
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                                  backgroundColor: showPetGallery
                                      ? AppColors.black
                                      : AppColors.transparent,
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: CustomButton(
                                  text: 'Owner\nGallery',
                                  onPressed: () {
                                    setState(() {
                                      showPosts = false;
                                      showVideo = false;
                                      showPetGallery = false;
                                      showOwnerGallery = true;
                                    });
                                  },
                                  textStyle: h3.copyWith(
                                    color: showOwnerGallery
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
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
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: DummyData.posts.length,
                              itemBuilder: (context, index) {
                                final post = DummyData.posts[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: UserPostCard(
                                    postId: post['id'],
                                    userName: post['userName'] ?? '',
                                    location: post['location'] ?? '',
                                    profileImage: post['profileImage'] ?? '',
                                    images:
                                        List<String>.from(post['images'] ?? []),
                                    description: post['description'] ?? '',
                                    likeCount: post['likeCount'] ?? 0,
                                    timeAgo: post['timeAgo'] ?? '',
                                    showAddFriendButton: false,
                                    popupMenuButton: CustomPopupMenuButton(
                                      items: [
                                        PopupMenuItemData(
                                          value: 'Edit Post',
                                          label: 'Edit Post',
                                          onSelected: () {
                                            Get.to(() => EditPostView(
                                                  location:
                                                      post['location'] ?? '',
                                                  images: List<String>.from(
                                                      post['images'] ?? []),
                                                  description:
                                                      post['description'] ?? '',
                                                ));
                                          },
                                        ),
                                        PopupMenuItemData(isDivider: true),
                                        PopupMenuItemData(
                                          value: 'Delete Post',
                                          label: 'Delete Post',
                                          onSelected: () {
                                            log('Delete Post selected');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          else if (showVideo)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1,
                              ),
                              itemCount: controller.myReelsData.length,
                              itemBuilder: (context, index) {
                                final reel = controller.myReelsData[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => MyReelsView(initialReel: reel,));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                      CircularProgressIndicator(color: AppColors.black,));
                                                } else if (snapshot.hasError ||
                                                    snapshot.data == null) {
                                                  return Image.asset(
                                                    AppImages.notFound,
                                                    fit: BoxFit.cover,
                                                  );
                                                } else {
                                                  return Image.file(
                                                    File(snapshot.data!),
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

                          // else if (showVideo)
                          //   GridView.builder(
                          //     shrinkWrap: true,
                          //     physics: const NeverScrollableScrollPhysics(),
                          //     gridDelegate:
                          //         const SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 2,
                          //       crossAxisSpacing: 12,
                          //       mainAxisSpacing: 12,
                          //       childAspectRatio: 1,
                          //     ),
                          //     itemCount: controller.myReelsData.length,
                          //     itemBuilder: (context, index) {
                          //       final reels = controller.myReelsData[index];
                          //       // final collection = DummyData.posts[index];
                          //       // final imageUrl =
                          //       //     (collection['images'] as List).isNotEmpty
                          //       //         ? collection['images'][0]
                          //       //         : AppImages.imageNotAvailable;
                          //       return GestureDetector(
                          //         onTap: () {
                          //           Get.to(() => ReelsView());
                          //         },
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(12),
                          //             color: AppColors.white,
                          //           ),
                          //           child: Stack(
                          //             children: [
                          //               Positioned.fill(
                          //                 child: ClipRRect(
                          //                   borderRadius:
                          //                       BorderRadius.circular(12),
                          //                   child: Image.network(
                          //                     reels.video ?? '',
                          //                     fit: BoxFit.cover,
                          //                   ),
                          //                 ),
                          //               ),
                          //               Positioned(
                          //                 left: 0,
                          //                 right: 0,
                          //                 child: Image.asset(
                          //                   AppImages.playSmall,
                          //                   scale: 4,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   )
                          else if (showPetGallery)
                            Column(
                              children: [
                                CustomButton(
                                  text: 'Upload an Image',
                                  onPressed: () {
                                    controller.uploadPetGalleryImage();
                                  },
                                  imageAssetPath: AppImages.uploadImage,
                                  backgroundColor: AppColors.fillColorTwo,
                                  textStyle: h3.copyWith(
                                    color: AppColors.secondaryOrangeColor,
                                  ),
                                ),
                                GridView.builder(
                                  padding: const EdgeInsets.only(top: 12),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount: controller.profileData.value!.data
                                          ?.gallery.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final imagePath = controller.profileData
                                        .value!.data!.gallery[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.white,
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                controller.profileData.value!
                                                    .data!.gallery[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 6,
                                            right: 6,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller
                                                    .patchRemovePetGalleryImage(
                                                        imagePath);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: ShapeDecoration(
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
                              ],
                            )
                          else if (showOwnerGallery)
                            Column(
                              children: [
                                CustomButton(
                                  text: 'Upload an Image',
                                  onPressed: () {
                                    controller.uploadOwnerGalleryImage();
                                  },
                                  imageAssetPath: AppImages.uploadImage,
                                  backgroundColor: AppColors.fillColorTwo,
                                  textStyle: h3.copyWith(
                                    color: AppColors.secondaryOrangeColor,
                                  ),
                                ),
                                GridView.builder(
                                  padding: const EdgeInsets.only(top: 12),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount: controller.profileData.value!.data
                                          ?.ownerGallery.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final imagePath = controller.profileData
                                        .value!.data!.ownerGallery[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.white,
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                controller.profileData.value!
                                                    .data!.ownerGallery[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 6,
                                            right: 6,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller
                                                    .patchRemoveOwnerGalleryImage(
                                                        imagePath);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: ShapeDecoration(
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
                              ],
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
            label,
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
