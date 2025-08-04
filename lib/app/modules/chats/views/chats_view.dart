// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/chats/controllers/chats_controller.dart';
// import 'package:tails_date/app/modules/chats/views/message_view.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/app_images/app_images.dart';
// import 'package:tails_date/common/app_text_style/styles.dart';
// import 'package:tails_date/common/widgets/custom_textfield.dart';
//
// import '../../../../common/size_box/custom_sizebox.dart';
//
// class ChatsView extends StatelessWidget {
//   final ChatsController controller = Get.put(ChatsController());
//
//   ChatsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Chats'),
//         // centerTitle: true,
//         automaticallyImplyLeading: false,
//         // leading: GestureDetector(
//         //   onTap: () {
//         //     Get.back();
//         //   },
//         //   child: Image.asset(
//         //     AppImages.back,
//         //     scale: 4,
//         //   ),
//         // ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16),
//             child: CustomTextField(
//               preIcon: Image.asset(
//                 AppImages.searchTwo,
//                 scale: 4,
//               ),
//               hintText: 'Search by name',
//             ),
//           ),
//           sh16,
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               'Active Now',
//               style: h3,
//             ),
//           ),
//           sh12,
//           SizedBox(
//             height: 60,
//             width: double.infinity,
//             child: ListView.builder(
//               shrinkWrap: true,
//               padding: EdgeInsets.symmetric(horizontal: 12),
//               scrollDirection: Axis.horizontal,
//               itemCount: 10,
//               itemBuilder: (context, index) => Stack(
//                 children: [
//                   Container(
//                     height: 60,
//                     width: 65,
//                     decoration: ShapeDecoration(
//                       shape: CircleBorder(),
//                       color: AppColors.white,
//                     ),
//                   ),
//                   Positioned(
//                     right: 4,
//                     top: 4,
//                     child: Container(
//                       height: 15,
//                       width: 15,
//                       decoration: ShapeDecoration(
//                         shape: CircleBorder(),
//                         color: AppColors.green,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           sh8,
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 itemCount: controller.users.length,
//                 itemBuilder: (context, index) {
//                   final user = controller.users[index];
//                   return Padding(
//                     padding: EdgeInsets.only(
//                         bottom: index == controller.users.length - 1 ? 20 : 0),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         radius: 25,
//                         backgroundImage: NetworkImage(user['picture']['thumbnail']),
//                       ),
//                       title: Text(
//                           '${user['name']['first']} ${user['name']['last']}'),
//                       titleTextStyle: h3,
//                       subtitle: const Text(
//                           'Hello, I really like your photo about...'),
//                       trailing: const Text('12:50'),
//                       onTap: () {
//                         Get.to(() => MessageView(user: user));
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tails_date/app/modules/chats/controllers/chats_controller.dart';
import 'package:tails_date/app/modules/chats/views/message_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../model/all_chat_model.dart';

class ChatsView extends StatelessWidget {
  final ChatsController controller = Get.put(ChatsController());

  ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch user ID once outside the builders
    final String? userId = LocalStorage.getData(key: AppConstant.userId);

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomTextField(
              preIcon: Image.asset(
                AppImages.searchTwo,
                scale: 4,
              ),
              hintText: 'Search by name',
            ),
          ),
          sh16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Active Now',
              style: h3,
            ),
          ),
          sh12,
          SizedBox(
            height: 60,
            width: double.infinity,
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  // Filter participants to exclude current user
                  final participant = chat.participants.firstWhere(
                    (p) => p.id != userId,
                    orElse: () =>
                        Participant(id: null, image: null, name: null),
                  );
                  // Skip if participant is invalid or matches current user
                  if (participant.id == null || participant.id == userId) {
                    return const SizedBox.shrink();
                  }
                  return Stack(
                    children: [
                      Container(
                        height: 60,
                        width: 65,
                        decoration: ShapeDecoration(
                          shape: const CircleBorder(),
                          color: AppColors.white,
                          image: participant.image != null
                              ? DecorationImage(
                                  image: NetworkImage(participant.image!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: participant.image == null
                            ? Center(
                                child: Text(
                                  participant.name?.substring(0, 1) ?? 'U',
                                  style: h3,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            color: AppColors.green,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          sh8,
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  // Filter participants to exclude current user
                  final participant = chat.participants.firstWhere(
                    (p) => p.id != userId,
                    orElse: () =>
                        Participant(id: null, image: null, name: null),
                  );
                  // Skip if participant is invalid or matches current user
                  if (participant.id == null || participant.id == userId) {
                    return const SizedBox.shrink();
                  }
                  // Get the most recent message (assuming first in list is latest)
                  final lastMessage = chat.lastMessage.isNotEmpty
                      ? chat.lastMessage.first
                      : null;
                  // Format the timestamp
                  String timeText = 'No messages';
                  if (lastMessage?.createdAt != null) {
                    timeText =
                        DateFormat('h:mm a').format(lastMessage!.createdAt!);
                  }
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == controller.chats.length - 1 ? 20 : 0,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: participant.image != null
                            ? NetworkImage(participant.image!)
                            : null,
                        child: participant.image == null
                            ? Text(
                                participant.name?.substring(0, 1) ?? 'U',
                                style: h3,
                              )
                            : null,
                      ),
                      title: Text(participant.name ?? 'Unknown User'),
                      titleTextStyle: h3,
                      subtitle: Text(
                        lastMessage?.text ?? 'No messages',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(timeText),
                      onTap: () {
                        Get.to(() => MessageView(
                              chatId: chat.id ?? '',
                              userImage: participant.image ?? '',
                              userName: participant.name ?? '',
                            ));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
