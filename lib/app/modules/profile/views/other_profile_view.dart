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
import '../../home/views/widgets/home_widgets/user_post_card.dart';

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
    profileController
        .fetchOtherProfile(widget.userId); // Fetch other user's profile
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
        title: const Text('User Profile'),
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
                ? const Center(child: Text('Failed to load user profile'))
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
                                  text: 'Friends',
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
                                  text: 'Message',
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
                                  value: profileController.otherProfileData
                                          .value!.data?.gender ??
                                      'N/A',
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: AttributeTile(
                                  label: 'Age',
                                  value: profileController
                                          .otherProfileData.value!.data?.age
                                          ?.toString() ??
                                      'N/A',
                                ),
                              ),
                              sw12,
                              Expanded(
                                child: AttributeTile(
                                  label: 'Category',
                                  value: profileController.otherProfileData
                                          .value!.data?.category ??
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
                                    .otherProfileData.value!.data?.petInfo ??
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
                                '${profileController.otherProfileData.value!.data?.ownerRelationshipStatus ?? 'N/A'}, ${profileController.otherProfileData.value!.data?.ownerGender ?? 'N/A'}',
                                style: h6,
                              ),
                            ),
                          ),
                          sh16,
                          // Posts and Collections Toggle
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
