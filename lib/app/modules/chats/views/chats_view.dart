import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/controllers/chats_controller.dart';
import 'package:tails_date/app/modules/chats/views/message_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/helper/date_formatter.dart';
import 'package:tails_date/common/helper/local_store.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';
import '../../../../Services/socket_services.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../model/all_chat_model.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final ChatsController controller = Get.put(ChatsController());
  final SocketService socketService = Get.put(SocketService());
  final TextEditingController searchCtrl = TextEditingController();
  String search = '';

  @override
  void initState() {
    super.initState();
    socketService.init();

    // Listen to search input changes
    searchCtrl.addListener(() {
      setState(() {
        search = searchCtrl.text;
      });
    });

    socketService.socket.on('chat-list', (data) {
      print('Socket chat list data received ...............');
      print('Raw data: $data');
      _handleIncomingFriends(data);
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void _handleIncomingFriends(dynamic data) {
    if (data == null) return;

    if (data is List) {
      socketService.socketFriendList.clear();
      for (var friend in data) {
        if (friend is Map<String, dynamic> && friend['participants'] != null) {
          socketService.socketFriendList.add({
            "receiverId": friend['last_message']['receiver'],
            "name": friend['participants'][1]['name'],
            "profileImage": friend['participants'][1]['image'],
            "lastMessage": friend['last_message']['text'] ?? '',
            "lastMessageTime": friend['last_message']['createdAt'] != null
                ? DateTime.parse(friend['last_message']['createdAt'])
                : DateTime.now(),
            "isSeen": friend['last_message']['seen'] ?? false,
          });
        }
      }
      socketService.socketFriendList.refresh();
    } else if (data is Map<String, dynamic>) {
      final newFriend = {
        "receiverId": data['last_message']['receiver'],
        "name": data['participants'][1]['name'],
        "profileImage": data['participants'][1]['image'],
        "lastMessage": data['last_message']['text'] ?? '',
        "lastMessageTime": data['last_message']['createdAt'] != null
            ? DateTime.parse(data['last_message']['createdAt'])
            : DateTime.now(),
        "isSeen": data['last_message']['seen'] ?? false,
      };

      final existingIndex = socketService.socketFriendList
          .indexWhere((f) => f['id'] == newFriend['id']);

      if (existingIndex != -1) {
        socketService.socketFriendList[existingIndex] = newFriend;
      } else {
        socketService.socketFriendList.add(newFriend);
      }
      socketService.socketFriendList.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = LocalStorage.getData(key: AppConstant.userId);

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Chats'.tr),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        // Show loader when data is initially loading
        if (socketService.socketFriendList.isEmpty &&
            controller.chatsList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.black,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CustomTextField(
                controller: searchCtrl, // Attach the search controller
                preIcon: Image.asset(
                  AppImages.searchTwo,
                  scale: 4,
                ),
                hintText: 'Search_By_Name'.tr,
              ),
            ),
            sh16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Active_Now'.tr,
                style: h3,
              ),
            ),
            sh12,
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Obx(
                    () {
                  // Filter the active users list based on search input
                  final activeFilteredFriends = socketService.socketFriendList
                      .asMap()
                      .entries
                      .where((entry) {
                    final friend = entry.value;
                    final name = friend['name']?.toLowerCase() ?? '';
                    return search.isEmpty ||
                        name.contains(search.toLowerCase());
                  })
                      .toList();

                  if (activeFilteredFriends.isEmpty) {
                    return Center(
                      child: Text(
                        'No_Active_Users_Found'.tr,
                        style: h5.copyWith(color: AppColors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    scrollDirection: Axis.horizontal,
                    itemCount: activeFilteredFriends.length,
                    itemBuilder: (context, index) {
                      final entry = activeFilteredFriends[index];
                      final originalIndex = entry.key;
                      final chat = controller.chatsList[originalIndex];
                      final participant = chat.participants.firstWhere(
                            (p) => p.id != userId,
                        orElse: () => Participant(id: null, image: null, name: null),
                      );
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
                  );
                },
              ),
            ),
            sh8,
            Expanded(
              child: Obx(
                    () {
                  // Filter the chat list based on search input
                  final filteredFriends = socketService.socketFriendList
                      .asMap()
                      .entries
                      .where((entry) {
                    final friend = entry.value;
                    final name = friend['name']?.toLowerCase() ?? '';
                    return search.isEmpty ||
                        name.contains(search.toLowerCase());
                  })
                      .toList();

                  if (filteredFriends.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No_Results_For'.trParams({
                              '0': search.isEmpty ? 'Chats'.tr : search,
                            }),
                            style: h3.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredFriends.length,
                    itemBuilder: (context, index) {
                      final entry = filteredFriends[index];
                      final originalIndex = entry.key;
                      final chat = controller.chatsList[originalIndex];
                      final friend = entry.value;
                      final participant = chat.participants.firstWhere(
                            (p) => p.id != userId,
                        orElse: () => Participant(id: null, image: null, name: null),
                      );

                      if (participant.id == null || participant.id == userId) {
                        return const SizedBox.shrink();
                      }
                      final lastMessage = chat.lastMessage.isNotEmpty
                          ? chat.lastMessage.first
                          : null;
                      final dateFormatter = DateFormatter(
                        friend['lastMessageTime'] ?? DateTime.now(),
                      );
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == filteredFriends.length - 1 ? 20 : 0,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: friend['profileImage'] != null
                                ? NetworkImage(friend['profileImage'])
                                : null,
                            child: participant.image == null
                                ? Text(
                              participant.name?.substring(0, 1) ?? 'U',
                              style: h3,
                            )
                                : null,
                          ),
                          title: Text(friend['name'] ?? 'Unknown User'),
                          titleTextStyle: h3,
                          subtitle: Text(
                            friend['lastMessage'] ?? 'No messages',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(dateFormatter.getTimeIn12HourFormat()),
                          onTap: () {
                            Get.to(() => MessageView(
                              chatId: chat.id ?? '',
                              userImage: participant.image ?? '',
                              userName: participant.name ?? '',
                              receiverId: lastMessage?.receiver ?? '',
                            ));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:tails_date/app/modules/chats/controllers/chats_controller.dart';
// import 'package:tails_date/app/modules/chats/views/message_view.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/app_images/app_images.dart';
// import 'package:tails_date/common/app_text_style/styles.dart';
// import 'package:tails_date/common/helper/date_formatter.dart';
// import 'package:tails_date/common/helper/local_store.dart';
// import 'package:tails_date/common/size_box/custom_sizebox.dart';
// import 'package:tails_date/common/widgets/custom_textfield.dart';
// import '../../../../Services/socket_services.dart';
// import '../../../../common/app_constant/app_constant.dart';
// import '../model/all_chat_model.dart';
//
// class ChatsView extends StatefulWidget {
//   const ChatsView({super.key});
//
//   @override
//   State<ChatsView> createState() => _ChatsViewState();
// }
//
// class _ChatsViewState extends State<ChatsView> {
//   final ChatsController controller = Get.put(ChatsController());
//   final SocketService socketService = Get.put(SocketService());
//   final TextEditingController searchCtrl = TextEditingController();
//   String search = '';
//
//   @override
//   void initState() {
//     super.initState();
//     socketService.init();
//
//     searchCtrl.addListener(() {
//       setState(() {
//         search = searchCtrl.text;
//       });
//     });
//
//     socketService.socket.on('chat-list', (data) {
//       _handleIncomingFriends(data);
//     });
//   }
//
//   @override
//   void dispose() {
//     searchCtrl.dispose();
//     super.dispose();
//   }
//
//   void _handleIncomingFriends(dynamic data) {
//     if (data == null) return;
//
//     if (data is List) {
//       socketService.socketFriendList.clear();
//       for (var friend in data) {
//         if (friend is Map<String, dynamic> && friend['participants'] != null) {
//           socketService.socketFriendList.add({
//             "receiverId": friend['last_message']['receiver'],
//             "name": friend['participants'][1]['name'],
//             "profileImage": friend['participants'][1]['image'],
//             "lastMessage": friend['last_message']['text'] ?? '',
//             "lastMessageTime": friend['last_message']['createdAt'] != null
//                 ? DateTime.parse(friend['last_message']['createdAt'])
//                 : DateTime.now(),
//             "isSeen": friend['last_message']['seen'] ?? false,
//           });
//         }
//       }
//       socketService.socketFriendList.refresh();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final String? userId = LocalStorage.getData(key: AppConstant.userId);
//
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: Text('Chats'.tr),
//         automaticallyImplyLeading: false,
//       ),
//       body: Obx(() {
//         // Show shimmer loader when data is initially loading
//         if (socketService.socketFriendList.isEmpty && controller.chatsList.isEmpty) {
//           return ListView.builder(
//             itemCount: 5, // Number of shimmer loading placeholders
//             itemBuilder: (context, index) {
//               return Shimmer.fromColors(
//                 baseColor: Colors.grey[300]!,
//                 highlightColor: Colors.grey[100]!,
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Colors.white,
//                   ),
//                   title: Container(
//                     width: double.infinity,
//                     height: 20.0,
//                     color: Colors.white,
//                   ),
//                   subtitle: Container(
//                     width: double.infinity,
//                     height: 15.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 16, right: 16),
//               child: CustomTextField(
//                 controller: searchCtrl,
//                 preIcon: Image.asset(
//                   AppImages.searchTwo,
//                   scale: 4,
//                 ),
//                 hintText: 'Search_By_Name'.tr,
//               ),
//             ),
//             sh16,
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'Active_Now'.tr,
//                 style: h3,
//               ),
//             ),
//             sh12,
//             SizedBox(
//               height: 60,
//               width: double.infinity,
//               child: Obx(
//                     () {
//                   final activeFilteredFriends = socketService.socketFriendList
//                       .asMap()
//                       .entries
//                       .where((entry) {
//                     final friend = entry.value;
//                     final name = friend['name']?.toLowerCase() ?? '';
//                     return search.isEmpty || name.contains(search.toLowerCase());
//                   }).toList();
//
//                   if (activeFilteredFriends.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No_Active_Users_Found'.tr,
//                         style: h5.copyWith(color: AppColors.white),
//                       ),
//                     );
//                   }
//
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     scrollDirection: Axis.horizontal,
//                     itemCount: activeFilteredFriends.length,
//                     itemBuilder: (context, index) {
//                       final entry = activeFilteredFriends[index];
//                       final participant = entry.value;
//                       return Stack(
//                         children: [
//                           Container(
//                             height: 60,
//                             width: 65,
//                             decoration: ShapeDecoration(
//                               shape: const CircleBorder(),
//                               color: AppColors.white,
//                               image: participant['profileImage'] != null
//                                   ? DecorationImage(
//                                 image: NetworkImage(participant['profileImage']),
//                                 fit: BoxFit.cover,
//                               )
//                                   : null,
//                             ),
//                             child: participant['profileImage'] == null
//                                 ? Center(
//                               child: Text(
//                                 participant['name']?.substring(0, 1) ?? 'U',
//                                 style: h3,
//                               ),
//                             )
//                                 : null,
//                           ),
//                           Positioned(
//                             right: 4,
//                             top: 4,
//                             child: Container(
//                               height: 15,
//                               width: 15,
//                               decoration: ShapeDecoration(
//                                 shape: const CircleBorder(),
//                                 color: AppColors.green,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             sh8,
//             Expanded(
//               child: Obx(
//                     () {
//                   final filteredFriends = socketService.socketFriendList
//                       .asMap()
//                       .entries
//                       .where((entry) {
//                     final friend = entry.value;
//                     final name = friend['name']?.toLowerCase() ?? '';
//                     return search.isEmpty || name.contains(search.toLowerCase());
//                   }).toList();
//
//                   if (filteredFriends.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'No_Results_For'.trParams({
//                               '0': search.isEmpty ? 'Chats'.tr : search,
//                             }),
//                             style: h3.copyWith(color: AppColors.white),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//
//                   return ListView.builder(
//                     itemCount: filteredFriends.length,
//                     itemBuilder: (context, index) {
//                       final entry = filteredFriends[index];
//                       final chat = controller.chatsList[index];
//                       final friend = entry.value;
//                       final participant = chat.participants.firstWhere(
//                             (p) => p.id != userId,
//                         orElse: () => Participant(id: null, image: null, name: null),
//                       );
//
//                       if (participant.id == null || participant.id == userId) {
//                         return const SizedBox.shrink();
//                       }
//                       final lastMessage = chat.lastMessage.isNotEmpty ? chat.lastMessage.first : null;
//                       final dateFormatter = DateFormatter(friend['lastMessageTime'] ?? DateTime.now());
//
//                       return Padding(
//                         padding: EdgeInsets.only(
//                           bottom: index == filteredFriends.length - 1 ? 20 : 0,
//                         ),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             radius: 25,
//                             backgroundImage: friend['profileImage'] != null
//                                 ? NetworkImage(friend['profileImage'])
//                                 : null,
//                             child: participant.image == null
//                                 ? Text(participant.name?.substring(0, 1) ?? 'U', style: h3)
//                                 : null,
//                           ),
//                           title: Text(friend['name'] ?? 'Unknown User'),
//                           subtitle: Text(friend['lastMessage'] ?? 'No messages'),
//                           trailing: Text(dateFormatter.getTimeIn12HourFormat()),
//                           onTap: () {
//                             Get.to(() => MessageView(
//                               chatId: chat.id ?? '',
//                               userImage: participant.image ?? '',
//                               userName: participant.name ?? '',
//                               receiverId: lastMessage?.receiver ?? '',
//                             ));
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
