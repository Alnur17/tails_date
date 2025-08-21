// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
//
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../../../common/widgets/custom_button.dart';
// import '../../../../common/widgets/custom_textfield.dart';
//
// class FriendsView extends GetView {
//   final List<Map<String, dynamic>> data;
//   const FriendsView( {super.key,required this.data});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Friends'),
//         centerTitle: true,
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
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16),
//             child: CustomTextField(
//               preIcon: Image.asset(
//                 AppImages.searchTwo,
//                 scale: 4,
//               ),
//               hintText: 'Search Friends',
//             ),
//           ),
//           sh12,
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 final item = data[index];
//                 return ListTile(
//                   onTap: (){
//                     log('list tapped ${index + 1}');
//                   },
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(item['image']!),
//                   ),
//                   title: Text(item['name']!),
//                   trailing: CustomButton(
//                     text: 'Message',
//                     onPressed: () {
//                       log('message tapped ${index + 1}');
//                     },
//                     width: Get.width * 0.30,
//                      height: 30,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/views/message_view.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../chats/controllers/chats_controller.dart';
import '../controllers/my_friends_controller.dart';

class FriendsView extends GetView<MyFriendsController> {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyFriendsController()); // Initialize the controller
    final chatController = Get.put(ChatsController());

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
              ? const Center(child: CircularProgressIndicator())
              : controller.errorMessage.isNotEmpty
              ? Center(
              child: Text(controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red)))
              : Expanded(
            child: Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.friendsList.length,
              itemBuilder: (context, index) {
                final friend = controller.friendsList[index];
                final friendName =
                    friend.receiver?.name ?? 'Unknown'.tr; // Localized
                final friendImage = friend.receiver?.image ?? '';

                return ListTile(
                  onTap: () {
                    debugPrint('Friend tapped: $friendName');
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(friendImage),
                  ),
                  title: Text(friendName),
                  subtitle: Text(friend.receiver?.email ?? ''),
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
