import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/data/dummy_data.dart';
import 'package:tails_date/app/modules/home/views/widgets/home_widgets/user_post_card.dart';
import 'package:tails_date/app/modules/profile/views/edit_profile_view.dart';
import 'package:tails_date/app/modules/profile/views/friends_view.dart';
import 'package:tails_date/app/modules/profile/views/profile_setting_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_popup_menu_button.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool showPosts = true; // To toggle between posts and collections

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //   onTap: () {
        //     Get.back();
        //   },
        //   child: Image.asset(
        //     AppImages.back,
        //     scale: 4,
        //   ),
        // ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProfileSettingView());
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover photo and profile picture
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(AppImages.groupOfDogs),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: AppColors.black,
                        ),
                        child: Image.asset(
                          AppImages.media,
                          scale: 4,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: 12,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(AppImages.profileImage),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              log("Add icon tapped");
                            },
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.black,
                              child: Icon(
                                Icons.add,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              sh60,
              // Profile info
              Text(
                'Piku_The_King',
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
                    '231-A, Florida, USA.',
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
                        Get.to(() => FriendsView(data: DummyData.friends));
                      },
                      text: '${DummyData.friends.length} Friends',
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.black,
                      textStyle: h3.copyWith(color: AppColors.black),
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
                      child: AttributeTile(label: 'Gender', value: 'Male')),
                  sw12,
                  Expanded(child: AttributeTile(label: 'Age', value: '1 Year')),
                  sw12,
                  Expanded(
                      child: AttributeTile(label: 'Category', value: 'Cat')),
                ],
              ),
              sh20,
              // Pet info
              Text(
                'Pet info',
                style: h2.copyWith(fontSize: 18),
              ),
              sh16,
              Text(
                'Hi, I’m Gultush! I’m a cheerful and energetic cat who loves to explore and play all day long. My favorite activities include chasing toys, basking in sunny spots, and snuggling up for cozy naps. I’m not just a pet—I’m a bundle of joy that brings endless happiness and love to my family! 🐾✨',
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
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      AppImages.loginImage,
                    ),
                  ),
                  title: Text(
                    'Ria Tamanna',
                    style: h4,
                  ),
                  subtitle: Text(
                    'Single, Female',
                    style: h6,
                  ),
                ),
              ),
              sh16,
              // Posts and Collections Toggle
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Posts',
                      onPressed: () {
                        setState(() {
                          showPosts = true;
                        });
                      },
                      textStyle: h3.copyWith(
                        color: !showPosts ? Colors.black : Colors.white,
                      ),
                      backgroundColor:
                          showPosts ? AppColors.black : AppColors.transparent,
                    ),
                  ),
                  sw12,
                  Expanded(
                    child: CustomButton(
                      text: 'Reels',
                      onPressed: () {
                        setState(() {
                          showPosts = false;
                        });
                      },
                      textStyle: h3.copyWith(
                        color: !showPosts ? Colors.white : Colors.black,
                      ),
                      backgroundColor:
                          !showPosts ? AppColors.black : AppColors.transparent,
                    ),
                  ),
                ],
              ),
              sh20,
              // Posts or Collections
              showPosts
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: DummyData.posts.length,
                      itemBuilder: (context, index) {
                        final post = DummyData.posts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: UserPostCard(
                            userName: post['userName'] ?? '',
                            location: post['location'] ?? '',
                            profileImage: post['profileImage'] ?? '',
                            images: List<String>.from(post['images'] ?? []),
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
                                    log('Edit Post selected');
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
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemCount: DummyData.posts.length,
                      itemBuilder: (context, index) {
                        final collection = DummyData.posts[index];
                        final imageUrl = (collection['images']).isNotEmpty
                            ? collection['images'][0]
                            : AppImages.imageNotAvailable;
                        return GestureDetector(
                          onTap: () {
                            log(
                                "Reels tapped: ${collection['description']}");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              sh20,
            ],
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
