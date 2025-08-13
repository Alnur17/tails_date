import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
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

import '../../home/views/widgets/home_widgets/user_post_card.dart';

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

  final ProfileController profileController = Get.put(ProfileController());
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController
        .fetchMyPosts(); // Fetch my posts when the view is initialized
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
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProfileSettingView(
                    profileImage:
                        profileController.profileData.value!.data?.image ?? '',
                    name: profileController.profileData.value!.data?.name ??
                        'N/A',
                    location:
                        profileController.profileData.value!.data?.location ??
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
        () => profileController.isLoading.value ||
                homeController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.black,
              ))
            : profileController.profileData.value == null
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
                                    image: profileController.coverImage.value !=
                                            null
                                        ? File(profileController.coverImage.value!.path)
                                                .existsSync()
                                            ? FileImage(File(profileController
                                                .coverImage.value!.path))
                                            : const AssetImage(
                                                    AppImages.groupOfDogs)
                                                as ImageProvider
                                        : profileController.profileData.value
                                                    ?.data?.coverImage !=
                                                null
                                            ? NetworkImage(profileController
                                                .profileData
                                                .value!
                                                .data!
                                                .coverImage!)
                                            : const AssetImage(
                                                AppImages.groupOfDogs),
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
                                              .selectedImage.value !=
                                          null
                                      ? File(profileController
                                                  .selectedImage.value!.path)
                                              .existsSync()
                                          ? FileImage(
                                              File(
                                                  profileController
                                                      .selectedImage
                                                      .value!
                                                      .path))
                                          : const AssetImage(
                                                  AppImages
                                                      .profileImage)
                                              as ImageProvider
                                      : profileController.profileData.value
                                                  ?.data?.image !=
                                              null
                                          ? NetworkImage(profileController
                                              .profileData.value!.data!.image!)
                                          : const AssetImage(
                                              AppImages.profileImage),
                                ),
                              ),
                            ],
                          ),
                          sh60,
                          // Profile info
                          Text(
                            profileController.profileData.value!.data?.name ??
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
                                profileController
                                        .profileData.value!.data?.location ??
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
                                    Get.to(() => FriendsView());
                                  },
                                  text:
                                      '${profileController.profileData.value?.data?.totalFriends} Friends',
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
                                    Get.to(() => EditProfileView(
                                          initialName: profileController
                                                  .profileData
                                                  .value!
                                                  .data
                                                  ?.name ??
                                              '',
                                          initialGender: profileController
                                                  .profileData
                                                  .value!
                                                  .data
                                                  ?.gender ??
                                              '',
                                          initialLocation: profileController
                                                  .profileData
                                                  .value!
                                                  .data
                                                  ?.location ??
                                              '',
                                          initialAge: profileController
                                              .profileData.value!.data?.age,
                                          initialCategory: profileController
                                                  .profileData
                                                  .value!
                                                  .data
                                                  ?.category ??
                                              '',
                                          initialPetInfo: profileController
                                                  .profileData
                                                  .value!
                                                  .data
                                                  ?.petInfo ??
                                              '',
                                          initialOwnerName: profileController
                                                  .profileData
                                                  .value!
                                                  .data
                                                  ?.ownerName ??
                                              '',
                                          initialOwnerRelationshipStatus:
                                              profileController
                                                      .profileData
                                                      .value!
                                                      .data
                                                      ?.ownerRelationshipStatus ??
                                                  '',
                                          initialOwnerGender: profileController
                                                  .profileData
                                                  .value!
                                                  .data
                                                  ?.ownerGender ??
                                              '',
                                        ));
                                    //     ?.then((_) async {
                                    //   imageCache.clear(); // Clear Flutter image cache
                                    //   imageCache.clearLiveImages();
                                    //   await profileController.fetchProfile(); // Refresh profile after edit
                                    // });
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
                                  value: profileController
                                          .profileData.value!.data?.gender ??
                                      'N/A',
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: AttributeTile(
                                  label: 'Age',
                                  value: profileController
                                          .profileData.value!.data?.age
                                          ?.toString() ??
                                      'N/A',
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: AttributeTile(
                                  label: 'Category',
                                  value: profileController
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
                            profileController
                                    .profileData.value!.data?.petInfo ??
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
                                backgroundImage:
                                    profileController.ownerImage.value != null
                                        ? File(profileController
                                                    .ownerImage.value!.path)
                                                .existsSync()
                                            ? FileImage(File(profileController
                                                .ownerImage.value!.path))
                                            : null
                                        : profileController.profileData.value
                                                    ?.data?.ownerImage !=
                                                null
                                            ? NetworkImage(profileController
                                                .profileData
                                                .value!
                                                .data!
                                                .ownerImage!)
                                            : null,
                              ),
                              title: Text(
                                profileController
                                        .profileData.value!.data?.ownerName ??
                                    'Unknown',
                                style: h4,
                              ),
                              subtitle: Text(
                                '${profileController.profileData.value!.data?.ownerRelationshipStatus ?? 'N/A'}, ${profileController.profileData.value!.data?.ownerGender ?? 'N/A'}',
                                style: h6,
                              ),
                              trailing: Text("Age: ${profileController.profileData.value!.data?.ownerAge ?? 'N/A'}" , style: h6,),
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
                            homeController.myPosts.isEmpty
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
                                    itemCount: homeController.myPosts.length,
                                    itemBuilder: (context, index) {
                                      final post =
                                          homeController.myPosts[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: UserPostCard(
                                          isMe: true,
                                          isSaved: true,
                                          isLiked: true,
                                          isFriend: true,
                                          onOtherProfileTap: () {},
                                          onBookmark: () {},
                                          postId: post.id ?? '',
                                          userName: post.author?.name ?? '',
                                          location: post.location ?? '',
                                          profileImage:
                                              post.author?.image ?? '',
                                          images: post.images,
                                          description: post.caption ?? '',
                                          likeCount: post.reactions.length,
                                          timeAgo: homeController
                                              .formatTimeAgo(post.createdAt),
                                          showAddFriendButton: false,
                                          onReaction: () {
                                            homeController
                                                .addOrRemoveReaction(post.id!);
                                          },
                                          popupMenuButton:
                                              CustomPopupMenuButton(
                                            items: [
                                              PopupMenuItemData(
                                                value: 'Edit Post',
                                                label: 'Edit Post',
                                                onSelected: () {
                                                  Get.to(() => EditPostView(
                                                        location:
                                                            post.location ?? '',
                                                        images: post.images,
                                                        description:
                                                            post.caption ?? '',
                                                        categoryId:
                                                            post.id ?? '',
                                                      ));
                                                },
                                              ),
                                              PopupMenuItemData(
                                                  isDivider: true),
                                              PopupMenuItemData(
                                                value: 'Delete Post',
                                                label: 'Delete Post',
                                                onSelected: () {
                                                  homeController.deletePost(
                                                      post.id ?? '');
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                          else if (showVideo)
                            profileController.myReelsData.isEmpty
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
                                        profileController.myReelsData.length,
                                    itemBuilder: (context, index) {
                                      final reel =
                                          profileController.myReelsData[index];
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
                            Column(
                              children: [
                                CustomButton(
                                  text: 'Upload an Image',
                                  onPressed: () {
                                    profileController.uploadPetGalleryImage();
                                  },
                                  imageAssetPath: AppImages.uploadImage,
                                  backgroundColor: AppColors.fillColorTwo,
                                  textStyle: h3.copyWith(
                                    color: AppColors.secondaryOrangeColor,
                                  ),
                                ),
                                (profileController.profileData.value!.data
                                            ?.gallery.isEmpty ??
                                        true)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 32),
                                        child: Image.asset(
                                            AppImages.profileBack,
                                            scale: 4),
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
                                        itemCount: profileController.profileData
                                                .value!.data?.gallery.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          final imagePath = profileController
                                              .profileData
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
                                                          .profileData
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
                                      ),
                              ],
                            )
                          else if (showOwnerGallery)
                            Column(
                              children: [
                                CustomButton(
                                  text: 'Upload an Image',
                                  onPressed: () {
                                    profileController.uploadOwnerGalleryImage();
                                  },
                                  imageAssetPath: AppImages.uploadImage,
                                  backgroundColor: AppColors.fillColorTwo,
                                  textStyle: h3.copyWith(
                                    color: AppColors.secondaryOrangeColor,
                                  ),
                                ),
                                (profileController.profileData.value!.data
                                            ?.ownerGallery.isEmpty ??
                                        true)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 32),
                                        child: Image.asset(
                                            AppImages.profileBack,
                                            scale: 4),
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
                                                .profileData
                                                .value!
                                                .data
                                                ?.ownerGallery
                                                .length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          final imagePath = profileController
                                              .profileData
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
                                                          .profileData
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
