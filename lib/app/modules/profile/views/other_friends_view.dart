import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../chats/controllers/chats_controller.dart';
import '../../chats/views/message_view.dart';
import '../controllers/my_friends_controller.dart';

class OtherFriendsView extends StatefulWidget {
  final String userId;
  const OtherFriendsView({super.key, required this.userId});

  @override
  State<OtherFriendsView> createState() => _OtherFriendsViewState();
}

class _OtherFriendsViewState extends State<OtherFriendsView> {

  final controller = Get.put(MyFriendsController()); // Initialize the controller
  final chatController = Get.put(ChatsController());

  @override
  void initState() {
    super.initState();
    controller.fetchFriendsByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Friends'.tr), // Localized
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomTextField(
              preIcon: Image.asset(
                AppImages.searchTwo,
                scale: 4,
              ),
              hintText: 'Search_Friends'.tr, // Localized
              // onChanged: (value) {
              //   // Implement search functionality if needed
              // },
            ),
          ),
          sh12,
          Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator(color: AppColors.black,))
              : controller.errorMessage.isNotEmpty
              ? Center(
              child: Text(controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red)))
              : Expanded(
            child: Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.otherFriendsList.length,
              itemBuilder: (context, index) {
                final friend = controller.otherFriendsList[index];
                final friendName =
                    friend.sender?.name ?? 'Unknown'.tr; // Localized
                final friendImage = friend.sender?.image ?? '';

                return ListTile(
                  onTap: () {
                    debugPrint('Friend tapped: $friendName');
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friendImage),
                  ),
                  title: Text(friendName),
                  subtitle: Text(friend.sender?.email ?? ''),
                  trailing: CustomButton(
                    text: 'Message'.tr, // Localized
                    onPressed: () {
                      Get.to(
                            () => MessageView(
                          userImage: friendImage,
                          userName: friendName,
                          chatId:
                          chatController.chatsList.first.id,
                          receiverId: friend.sender?.id,
                        ),
                      );
                    },
                    width: Get.width * 0.30,
                    height: 30,
                  ),
                );
              },
            )),
          )),
        ],
      ),
    );
  }
}
