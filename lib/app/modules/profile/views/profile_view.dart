import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tails_date/app/modules/home/controllers/home_controller.dart';
import 'package:tails_date/app/modules/profile/controllers/profile_controller.dart';
import 'package:tails_date/app/modules/profile/views/add_more_pet_view.dart';
import 'package:tails_date/app/modules/profile/views/edit_profile_view.dart';
import 'package:tails_date/app/modules/profile/views/friends_view.dart';
import 'package:tails_date/app/modules/profile/views/my_reels_view.dart';
import 'package:tails_date/app/modules/profile/views/other_pet_details_view.dart';
import 'package:tails_date/app/modules/profile/views/profile_setting_view.dart';
import 'package:tails_date/app/modules/profile/views/widgets/others_pet_cart.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_popup_menu_button.dart';
import '../../home/views/widgets/home_widgets/user_post_card.dart';
import 'edit_post_view.dart';

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
    homeController.fetchMyPosts();
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
        title: Text('Profile_Title'.tr),
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
                ? Center(child: Text('Failed_To_Load_Profile'.tr))
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  profileController
                                          .profileData.value!.data?.name ??
                                      'Unknown',
                                  style: h2.copyWith(fontSize: 20),
                                ),
                              ),
                              sw5,
                              Expanded(
                                child: CustomButton(
                                  text: 'Add_More_Pet'.tr,
                                  onPressed: () {
                                    Get.to(()=> AddMorePetView());
                                  },
                                  //height: 40,
                                  backgroundColor: AppColors.fillColorTwo,
                                  textStyle: h5.copyWith(color: AppColors.secondaryOrangeColor),
                                  borderColor: AppColors.red,
                                ),
                              ),
                            ],
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
                                  },
                                  text: 'Edit_Profile'.tr,
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
                                  label: 'Category'.tr,
                                  value: profileController
                                          .profileData.value!.data?.category ??
                                      'N/A',
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: AttributeTile(
                                  label: 'Age'.tr,
                                  value: profileController
                                          .profileData.value!.data?.age
                                          ?.toString() ??
                                      'N/A',
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: AttributeTile(
                                  label: 'Gender'.tr,
                                  value: profileController
                                          .profileData.value!.data?.gender ??
                                      'N/A',
                                ),
                              ),
                            ],
                          ),
                          sh20,
                          // Pet info
                          Text(
                            'Pet_Info'.tr,
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
                          //Others Pet
                          Text(
                            "Others_Pet".tr,
                            style: h3,
                          ),
                          sh8,
                          SizedBox(
                            height: 160,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: profileController.profileData.value!.data?.pets.length,
                              itemBuilder: (context, index) {
                                final othersPetData = profileController.profileData.value!.data?.pets[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 0 : 8,
                                  ),
                                  child: OthersPetCard(
                                    onTap: () {
                                      Get.to(()=> OtherPetDetailsView(petId: othersPetData?.id ?? '',));
                                    },
                                    imageUrl:  othersPetData?.image ?? AppImages.catProfileImage,
                                    title:  othersPetData?.name ?? 'Unknown' ,
                                  ),
                                );
                              },
                            ),
                          ),
                          sh16,
                          // Pet Owner Info
                          Text(
                            'Pet_Owner'.tr,
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
                              trailing: Text(
                                "Age: ${profileController.profileData.value!.data?.ownerAge ?? 'N/A'}",
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
                                          popupMenuButton:
                                              CustomPopupMenuButton(
                                            items: [
                                              PopupMenuItemData(
                                                value: 'Edit_Post'.tr,
                                                label: 'Edit_Post'.tr,
                                                onSelected: () {
                                                  Get.to(() => EditPostView(
                                                        location:
                                                            post.location ?? '',
                                                        images: post.images,
                                                        description:
                                                            post.caption ?? '',
                                                        categoryId:
                                                            post.category ?? '', postId: post.id ?? '',
                                                      ));
                                                },
                                              ),
                                              PopupMenuItemData(
                                                  isDivider: true),
                                              PopupMenuItemData(
                                                value: 'Delete_Post'.tr,
                                                label: 'Delete_Post'.tr,
                                                onSelected: () {
                                                  homeController.deletePost(
                                                      post.id ?? '');
                                                },
                                              ),
                                            ],
                                          ),
                                          isFriend: true,
                                          isLiked: homeController
                                              .isPostLiked(post.id ?? ''),
                                          isSaved: homeController
                                              .isPostInCollections(
                                                  post.id ?? ''),
                                          isMe: post.author?.id ==
                                              LocalStorage.getData(
                                                  key: AppConstant.userId),
                                          onNotInterestedTap: () {
                                            homeController.addNotInterested(
                                              homeController.userId,
                                              post.id,
                                            );
                                            debugPrint(
                                                ";;;;;;;;;; ${homeController.userId};;;;;;;;");
                                          },
                                          onOtherProfileTap: () {},
                                          postId: post.id ?? '',
                                          userName:
                                              post.author?.name ?? 'Unknown',
                                          location: post.location ?? 'Unknown',
                                          profileImage:
                                              post.author?.image ?? '',
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
                                  text: 'Upload_Image'.tr,
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
                                  text: 'Upload_Image'.tr,
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
