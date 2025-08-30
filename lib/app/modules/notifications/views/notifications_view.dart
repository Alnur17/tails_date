import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_list_tile_with_button.dart';
import '../../../../common/widgets/custom_row_header.dart';
import '../controllers/notifications_controller.dart';
import '../model/friend_req_model.dart';
import '../model/notification_model.dart';
import 'friend_request_view.dart';
import 'send_request_view.dart';
import 'suggested_for_you_view.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationsController());

    // Trigger fetchFriendSuggestions when the view is built
    notificationController.fetchFriendSuggestions();

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text('Notifications'.tr),
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
                      text: 'Friend_Activity'.tr,
                      onPressed: () {
                        notificationController.toggleTab(0);
                      },
                      backgroundColor:
                      notificationController.activeTab.value == 0
                          ? AppColors.black
                          : AppColors.transparent,
                      textStyle: h5.copyWith(
                          color: notificationController.activeTab.value == 0
                              ? AppColors.white
                              : AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      text: 'Post_Engagement'.tr,
                      onPressed: () {
                        notificationController.toggleTab(1);
                      },
                      backgroundColor:
                      notificationController.activeTab.value == 1
                          ? AppColors.black
                          : AppColors.transparent,
                      textStyle: h5.copyWith(
                          color: notificationController.activeTab.value == 1
                              ? AppColors.white
                              : AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: notificationController.activeTab.value == 0
                  ? ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: _buildFriendActivity(notificationController),
              )
                  : FutureBuilder<NotificationModel>(
                future: notificationController.fetchNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.black));
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}'.tr,
                            style: h5.copyWith(color: AppColors.black)));
                  } else if (snapshot.hasData &&
                      snapshot.data!.data != null &&
                      snapshot.data!.data!.data.isNotEmpty) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: _postEngagementData(snapshot.data!),
                    );
                  } else {
                    return Center(
                        child: Text('No_Notifications_Available'.tr,
                            style: h5.copyWith(color: AppColors.black)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFriendActivity(
      NotificationsController notificationController) {
    final String userId = LocalStorage.getData(key: AppConstant.userId);

    return [
      sh12,
      FutureBuilder<FriendsReqModel>(
        future: notificationController.fetchFriendRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.black));
          } else if (snapshot.hasError) {
            return Column(
              children: [
                CustomRowHeader(
                  title: 'Friend_Requests'.tr,
                  subtitle: 'See_All'.tr,
                  onTap: () {},
                ),
                sh8,
                Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: h5.copyWith(color: AppColors.black),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData &&
              snapshot.data!.data != null &&
              snapshot.data!.data!.data.isNotEmpty) {
            final friendRequests = snapshot.data!.data!.data
                .where((item) => item.receiver?.id == userId)
                .map((item) => {
              'name': item.sender?.name ?? 'Unknown',
              'image': item.sender?.image ?? 'https://via.placeholder.com/150',
              'id': item.id ?? '',
              'status': item.status ?? 'pending',
            })
                .toList();

            final sendRequests = snapshot.data!.data!.data
                .where((item) => item.sender?.id == userId)
                .map((item) => {
              'name': item.receiver?.name ?? 'Unknown',
              'image': item.receiver?.image ?? 'https://via.placeholder.com/150',
              'id': item.id ?? '',
              'status': item.status ?? 'pending',
            })
                .toList();

            return Column(
              children: [
                CustomRowHeader(
                  title: 'Friend_Requests'.tr,
                  subtitle: 'See_All'.tr,
                  onTap: () {
                    Get.to(() => FriendRequestView(data: friendRequests));
                  },
                ),
                sh8,
                if (friendRequests.isEmpty)
                  Center(
                      child: Text(
                          'No_Friend_Requests'.tr,
                          style: h5.copyWith(color: AppColors.black)))
                else
                  ...friendRequests.take(5).map(
                        (item) => CustomListTileWithButton(
                      closeOnPressed: () {
                        notificationController.updateFriendRequest(
                            item['id']!, 'rejected');
                      },
                      name: item['name'] ?? 'Unknown',
                      actionText: 'Confirm'.tr,
                      showCloseButton: true,
                      actionOnPressed: () {
                        notificationController.updateFriendRequest(
                            item['id']!, 'accepted');
                      },
                      actionStyle: CustomButton(
                        width: 100,
                        height: 30,
                        text: 'Confirm'.tr,
                        onPressed: () {
                          notificationController.updateFriendRequest(
                              item['id']!, 'accepted');
                        },
                        borderColor: AppColors.black,
                        backgroundColor: AppColors.white,
                        textStyle: h3.copyWith(color: AppColors.black),
                      ),
                      image: item['image'] ?? 'https://via.placeholder.com/150',
                    ),
                  ),
                sh12,
                CustomRowHeader(
                  title: 'Send_Requests'.tr,
                  subtitle: 'See_All'.tr,
                  onTap: () {
                    Get.to(() => SendRequestView(data: sendRequests));
                  },
                ),
                sh8,
                if (sendRequests.isEmpty)
                  Center(
                      child: Text(
                          'No_Sent_Requests'.tr,
                          style: h5.copyWith(color: AppColors.black)))
                else
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: min(sendRequests.length, 5),
                    itemBuilder: (context, index) {
                      final item = sendRequests[index];
                      return CustomListTileWithButton(
                        name: item['name']!,
                        image: item['image']!,
                        actionText: 'Cancel_Request'.tr,
                        actionOnPressed: () {
                          notificationController
                              .deleteSendRequest(item['id']!);
                        },
                        actionStyle: CustomButton(
                          width: 165,
                          height: 30,
                          text: 'Cancel_Request'.tr,
                          onPressed: () {
                            notificationController
                                .deleteSendRequest(item['id']!);
                          },
                          backgroundColor: AppColors.secondaryOrangeColor,
                          textStyle: h3.copyWith(color: AppColors.white),
                        ),
                      );
                    },
                  ),
                sh12,
                CustomRowHeader(
                  title: 'Suggested_For_You'.tr,
                  subtitle: 'See_All'.tr,
                  onTap: () {
                    Get.to(() => SuggestedForYouView());
                  },
                ),
                sh8,
                Obx(() {
                  if (notificationController.isLoading.value) {
                    return const Center(
                        child:
                        CircularProgressIndicator(color: AppColors.black));
                  } else if (notificationController
                      .errorMessage.value.isNotEmpty) {
                    return Center(
                        child: Text(notificationController.errorMessage.value,
                            style: h5.copyWith(color: AppColors.black)));
                  } else if (notificationController
                      .friendsSuggestionList.isEmpty) {
                    return Center(
                        child: Text('No_Friend_Suggestions'.tr,
                            style: h5.copyWith(color: AppColors.black)));
                  } else {
                    return Column(
                      children: notificationController.friendsSuggestionList
                          .take(5)
                          .map(
                            (item) => CustomListTileWithButton(
                          name: item.name ?? 'Unknown',
                          actionText: 'Add_Friend'.tr,
                          actionOnPressed: () {
                            notificationController
                                .sendFriendRequest(item.id ?? '');
                          },
                          actionStyle: CustomButton(
                            width: 140,
                            height: 30,
                            text: 'Add_Friend'.tr,
                            onPressed: () {
                              notificationController
                                  .sendFriendRequest(item.id ?? '');
                            },
                            backgroundColor: AppColors.black,
                            textStyle: h3.copyWith(color: AppColors.white),
                          ),
                          image: item.image ?? 'https://via.placeholder.com/150',
                        ),
                      )
                          .toList(),
                    );
                  }
                }),
              ],
            );
          } else {
            return Column(
              children: [
                CustomRowHeader(
                  title: 'Friend_Requests'.tr,
                  subtitle: 'See_All'.tr,
                  onTap: () {},
                ),
                sh8,
                Center(
                    child: Text(
                        'No_Friend_Requests'.tr,
                        style: h5.copyWith(color: AppColors.black))),
                sh12,
                CustomRowHeader(
                  title: 'Send_Requests'.tr,
                  subtitle: 'See_All'.tr,
                  onTap: () {
                    Get.to(() => SendRequestView(data: []));
                  },
                ),
                sh8,
                Center(
                    child: Text(
                        'No_Sent_Requests'.tr,
                        style: h5.copyWith(color: AppColors.black))),
                sh12,
                CustomRowHeader(
                  title: 'Suggested_For_You'.tr,
                  subtitle: 'See_All'.tr,
                  onTap: () {
                    Get.to(() => SuggestedForYouView());
                  },
                ),
                sh8,
                Obx(() {
                  if (notificationController.isLoading.value) {
                    return const Center(
                        child:
                        CircularProgressIndicator(color: AppColors.black));
                  } else if (notificationController
                      .errorMessage.value.isNotEmpty) {
                    return Center(
                        child: Text(notificationController.errorMessage.value,
                            style: h5.copyWith(color: AppColors.black)));
                  } else if (notificationController
                      .friendsSuggestionList.isEmpty) {
                    return Center(
                        child: Text('No_Friend_Suggestions'.tr,
                            style: h5.copyWith(color: AppColors.black)));
                  } else {
                    return Column(
                      children: notificationController.friendsSuggestionList
                          .take(5)
                          .map(
                            (item) => CustomListTileWithButton(
                          name: item.name ?? 'Unknown',
                          actionText: 'Add_Friend'.tr,
                          actionOnPressed: () {
                            notificationController
                                .sendFriendRequest(item.id ?? '');
                          },
                          actionStyle: CustomButton(
                            width: 140,
                            height: 30,
                            text: 'Add_Friend'.tr,
                            onPressed: () {
                              notificationController
                                  .sendFriendRequest(item.id ?? '');
                            },
                            backgroundColor: AppColors.black,
                            textStyle: h3.copyWith(color: AppColors.white),
                          ),
                          image: item.image ?? 'https://via.placeholder.com/150',
                        ),
                      )
                          .toList(),
                    );
                  }
                }),
              ],
            );
          }
        },
      ),
    ];
  }

  List<Widget> _postEngagementData(NotificationModel notificationModel) {
    return [
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.only(top: 16),
        itemCount: notificationModel.data!.data.length,
        itemBuilder: (context, index) {
          final notification = notificationModel.data!.data[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: AppColors.black,
                  ),
                ),
                sw12,
                Container(
                  width: 54,
                  height: 54,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: AppColors.white,
                  ),
                  child: notification.image != null &&
                      notification.image is String &&
                      notification.image!.isNotEmpty
                      ? ClipOval(
                    child: Image.network(
                      notification.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                            AppImages.notificationTwo,
                            color: AppColors.black,
                            scale: 4,
                          ),
                    ),
                  )
                      : Image.asset(
                    AppImages.notificationTwo,
                    color: AppColors.black,
                    scale: 4,
                  ),
                ),
                sw12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title ?? 'No_Title'.tr,
                        style: h4.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      sh5,
                      Text(
                        notification.body ?? 'No_Description'.tr,
                        style: h5.copyWith(color: AppColors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
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
