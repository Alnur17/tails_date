
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/notifications/views/friend_request_view.dart';
import 'package:tails_date/app/modules/notifications/views/send_request_view.dart';
import 'package:tails_date/app/modules/notifications/views/suggested_for_you_view.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_list_tile.dart';
import '../../../../common/widgets/custom_row_header.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationsController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: const Text('Notifications'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      textStyle: TextStyle(
                        color: notificationController.activeTab.value == 1
                            ? Colors.white
                            : Colors.black,
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
                    ? _friendActivityData()
                    : _postEngagementData(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _friendActivityData() {
    return [
      sh12,
      CustomRowHeader(
        title: 'Friend Requests',
        subtitle: 'See all',
        onTap: () {
          Get.to(() => FriendRequestView());
        },
      ),
      CustomListTile(
        name: 'My_Python_King',
        actionText: 'Confirm',
        showCloseButton: true,
        actionOnPressed: () {},
        actionStyle: CustomButton(
          width: 100,
          height: 35,
          text: 'Confirm',
          onPressed: () {},
          borderColor: AppColors.black,
          backgroundColor: AppColors.white,
          textStyle: h3.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      sh12,
      CustomRowHeader(
        title: 'Send Requests',
        subtitle: 'See all',
        onTap: () {
          Get.to(() => SendRequestView());
        },
      ),
      CustomListTile(
        name: 'Bok_Bok',
        actionText: 'Cancel request',
        actionOnPressed: () {},
        closeOnPressed: () {},
        actionStyle: CustomButton(
          width: 140,
          height: 35,
          text: 'Cancel request',
          onPressed: () {},
          backgroundColor: AppColors.secondaryOrangeColor,
          textStyle: h3.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
      sh12,
      CustomRowHeader(
          title: 'Suggested for you',
          subtitle: 'See all',
          onTap: () {
            Get.to(() => SuggestedForYouView());
          }),
      CustomListTile(
        name: 'My_Python_King',
        actionText: 'Cancel request',
        actionOnPressed: () {},
        actionStyle: CustomButton(
          width: 140,
          height: 35,
          text: 'Add Friend',
          onPressed: () {},
        ),
      ),
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
                  height: 15,
                  width: 15,
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
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: h6.copyWith(fontWeight: FontWeight.w500),
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