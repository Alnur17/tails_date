// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../../../common/widgets/custom_button.dart';
// import '../../../../common/widgets/custom_textfield.dart';
// import '../controllers/notifications_controller.dart';
//
// class SuggestedForYouView extends GetView {
//   final List<Map<String, String>> data;
//   const SuggestedForYouView({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     final NotificationsController notificationController = Get.find();
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.mainColor,
//         title: Text('Suggested_For_You'.tr), // Updated to use translation
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Image.asset(AppImages.back, scale: 4),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16),
//             child: CustomTextField(
//               controller: notificationController.searchController,
//               preIcon: Image.asset(
//                 AppImages.searchTwo,
//                 scale: 4,
//               ),
//               hintText: 'Search_Friends'.tr, // Updated to use translation
//             ),
//           ),
//           sh12,
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: notificationController.filteredFriendsSuggestionList.length,
//               itemBuilder: (context, index) {
//                 final item = notificationController.filteredFriendsSuggestionList[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(item.image!),
//                   ),
//                   title: Text(item.name!),
//                   trailing: CustomButton(
//                     text: 'Add_Friend'.tr, // Updated to use translation
//                     onPressed: () {
//                       notificationController.sendFriendRequest(item.id ?? '');
//                     },
//                     width: 120,
//                     height: 30,
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

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/notifications_controller.dart';

class SuggestedForYouView extends GetView<NotificationsController> {
  const SuggestedForYouView({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationsController notificationsController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Suggested_For_You'.tr),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomTextField(
              controller: notificationsController.searchController,
              preIcon: Image.asset(
                AppImages.searchTwo,
                scale: 4,
              ),
              hintText: 'Search_Friends'.tr,
            ),
          ),
          sh12,
          Obx(() => notificationsController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : notificationsController.errorMessage.value.isNotEmpty
              ? Center(child: Text(notificationsController.errorMessage.value))
              : Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: notificationsController.filteredFriendsSuggestionList.length,
              itemBuilder: (context, index) {
                final item = notificationsController.filteredFriendsSuggestionList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(item.image ?? ''),
                  ),
                  title: Text(item.name ?? ''),
                  trailing: CustomButton(
                    text: 'Add_Friend'.tr,
                    onPressed: () {
                      notificationsController.sendFriendRequest(item.id ?? '');
                    },
                    width: 120,
                    height: 30,
                  ),
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}