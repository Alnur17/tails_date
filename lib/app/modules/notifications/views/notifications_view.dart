import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_images/app_images.dart';
import 'friend_request_view.dart'; // Separate screens for each section
import 'send_request_view.dart';
import 'suggested_for_you_view.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_list_tile_with_button.dart';
import '../../../../common/widgets/custom_row_header.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationsController());

    // Dummy data for each section
    final List<Map<String, String>> friendRequests = List.generate(
        10,
        (index) => {
              'name': 'Friend_$index',
              'image':
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
            });
    final List<Map<String, String>> sendRequests = List.generate(
        10,
        (index) => {
              'name': 'Request_$index',
              'image':
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
            });
    final List<Map<String, String>> suggestedForYou = List.generate(
        10,
        (index) => {
              'name': 'Suggested_$index',
              'image':
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=774&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
            });

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: const Text('Notifications'),
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
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 12),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Friend Activity',
                      onPressed: () {
                        notificationController.toggleTab(0);
                      },
                      backgroundColor:
                          notificationController.activeTab.value == 0
                              ? AppColors.black
                              : AppColors.transparent,
                      textStyle: h3.copyWith(
                        color: notificationController.activeTab.value == 0
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      text: 'Post Engagement',
                      onPressed: () {
                        notificationController.toggleTab(1);
                      },
                      backgroundColor:
                          notificationController.activeTab.value == 1
                              ? Colors.black
                              : AppColors.transparent,
                      textStyle: h3.copyWith(
                        color: notificationController.activeTab.value == 1
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: notificationController.activeTab.value == 0
                    ? _buildFriendActivity(
                        friendRequests, sendRequests, suggestedForYou)
                    : _postEngagementData(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFriendActivity(
    List<Map<String, String>> friendRequests,
    List<Map<String, String>> sendRequests,
    List<Map<String, String>> suggestedForYou,
  ) {
    return [
      // Friend Requests Section
      sh12,
      CustomRowHeader(
        title: 'Friend Requests',
        subtitle: 'See all',
        onTap: () {
          Get.to(
              () => FriendRequestView(data: friendRequests)); // Pass all data
        },
      ),
      sh8,
      ...friendRequests.take(5).map((item) => CustomListTileWithButton(
            name: item['name'] ?? 'Unknown',
            actionText: 'Confirm',
            showCloseButton: true,
            actionOnPressed: () {},
            actionStyle: CustomButton(
              width: 100,
              height: 30,
              text: 'Confirm',
              onPressed: () {},
              borderColor: AppColors.black,
              backgroundColor: AppColors.white,
              textStyle: h3.copyWith(
                color: AppColors.black,
              ),
            ),
            image: item['image'] ?? 'https://via.placeholder.com/150',
          )),

      // Send Requests Section
      sh12,
      CustomRowHeader(
        title: 'Send Requests',
        subtitle: 'See all',
        onTap: () {
          Get.to(() => SendRequestView(data: sendRequests)); // Pass all data
        },
      ),
      sh8,
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: min(sendRequests.length, 5),
        itemBuilder: (context, index) {
          final item = sendRequests[index];
          return CustomListTileWithButton(
            name: item['name']!,
            image: item['image']!,
            actionText: 'Cancel Request',
            actionOnPressed: () {},
            actionStyle: CustomButton(
              width: 150,
              height: 30,
              text: 'Cancel Request',
              onPressed: () {},
              backgroundColor: AppColors.secondaryOrangeColor,
              textStyle: h3.copyWith(color: AppColors.white),
            ),
          );
        },
      ),

      // Suggested for You Section
      sh12,
      CustomRowHeader(
        title: 'Suggested for You',
        subtitle: 'See all',
        onTap: () {
          Get.to(() =>
              SuggestedForYouView(data: suggestedForYou)); // Pass all data
        },
      ),
      sh8,
      ...suggestedForYou.map((item) => CustomListTileWithButton(
            name: item['name'] ?? 'Unknown',
            actionText: 'Add Friend',
            actionOnPressed: () {},
            actionStyle: CustomButton(
              width: 140,
              height: 30,
              text: 'Add Friend',
              onPressed: () {},
            ),
            image: item['image'] ?? 'https://via.placeholder.com/150',
          )),
    ];
  }

  List<Widget> _postEngagementData() {
    return [
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.only(top: 16),
        itemCount: 30,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: AppColors.black,
                  ),
                ),
                sw12,
                Container(
                  width: 54,
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                    color: AppColors.white,
                  ),
                  child: Image.asset(
                    AppImages.notificationTwo,
                    color: AppColors.black,
                    scale: 4,
                  ),
                ),
                sw12,
                Expanded(
                  child: Text(
                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                    style: h5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ];
  }
}
