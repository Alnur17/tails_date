import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tails_date/app/modules/chats/views/message_settings_view.dart';

import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../controllers/chats_controller.dart';

class MessageView extends StatefulWidget {
  final String? chatId;
  final String? userName;
  final String? userImage;
  final String? receiverId;

  const MessageView({
    super.key,
    this.chatId,
    this.userImage,
    this.userName,
    this.receiverId,
  });

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final ChatsController controller = Get.put(ChatsController());
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.chatId != null) {
      controller.fetchMessageBody(widget.chatId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        titleSpacing: 0,
        title: GestureDetector(
          onTap: () {
            Get.to(() => MessageSettingsView(
                  userName: widget.userName,
                  userImage: widget.userImage,
                ));
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.userImage ?? ''),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userName ?? ''),
                  Text('Online',
                      style:
                          h5.copyWith(color: AppColors.secondaryOrangeColor)),
                ],
              ),
            ],
          ),
        ),
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
      body: Obx(() => Column(
            children: [
              Expanded(
                child: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: controller.messageList.length,
                        itemBuilder: (context, index) {
                          final message = controller.messageList[index];
                          final isSender =
                              message.sender == LocalStorage.getData(key: AppConstant.userId);
                          return _buildChatBubble(
                            message: message.text ?? '',
                            isSender: isSender,
                            time: _formatTime(message.createdAt),
                          );
                        },
                      ),
              ),
              _buildMessageInput(
                controller: controller,
                messageController: messageController,
                chatId: widget.chatId,
              ),
            ],
          )),
    );
  }

  Widget _buildChatBubble({
    required String message,
    required bool isSender,
    required String time,
  }) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSender ? AppColors.secondaryOrangeColor : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isSender ? Radius.circular(12) : Radius.zero,
            bottomRight: isSender ? Radius.zero : Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: h4.copyWith(
                  color: isSender ? AppColors.white : AppColors.black),
            ),
            sh5,
            Text(
              time,
              style: h6.copyWith(
                  color: isSender ? AppColors.white : AppColors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput({
    required ChatsController controller,
    required TextEditingController messageController,
    required String? chatId,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
            ),
            child: IconButton(
              icon: Image.asset(AppImages.fileAttachment, scale: 4),
              onPressed: () {},
            ),
          ),
          sw8,
          Expanded(
            child: CustomTextField(
              controller: messageController,
              hintText: "Message",
              borderColor: AppColors.black,
              sufIcon: IconButton(
                icon: Image.asset(
                  AppImages.send,
                  scale: 4,
                ),
                onPressed: () {
                    if (messageController.text.trim().isNotEmpty && widget.chatId != null && widget.receiverId != null) {
                      controller.sendMessage(widget.chatId!, messageController.text.trim(), widget.receiverId!);
                      messageController.clear();
                    }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final time = TimeOfDay.fromDateTime(dateTime);
    return time.format(Get.context!);
  }
}

extension ChatsControllerExtension on ChatsController {
  String? getCurrentUserId() {
    String token = LocalStorage.getData(key: AppConstant.token);
    if (token.isNotEmpty) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['id'] ?? decodedToken['_id'];
    }
    return null;
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:tails_date/app/modules/chats/views/message_settings_view.dart';
//
// import '../../../../../common/size_box/custom_sizebox.dart';
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../../../common/widgets/custom_textfield.dart';
// import '../controllers/chats_controller.dart';
//
// class MessageView extends StatefulWidget {
//   final String? chatId;
//   final String? userName;
//   final String? userImage;
//   final String? receiverId; // Added receiverId parameter
//
//   const MessageView({
//     super.key,
//     this.chatId,
//     this.userImage,
//     this.userName,
//     this.receiverId, // Made required for WebSocket
//   });
//
//   @override
//   State<MessageView> createState() => _MessageViewState();
// }
//
// class _MessageViewState extends State<MessageView> {
//   final ChatsController controller = Get.put(ChatsController());
//   final TextEditingController messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController(); // Added for scrolling
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.chatId != null) {
//       controller.fetchMessageBody(widget.chatId!);
//     }
//     // Scroll to bottom when messages are updated
//     controller.messageList.listen((_) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (_scrollController.hasClients) {
//           _scrollController.animateTo(
//             _scrollController.position.maxScrollExtent,
//             duration: Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//           );
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     messageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         titleSpacing: 0,
//         title: GestureDetector(
//           onTap: () {
//             Get.to(() => MessageSettingsView(
//               userName: widget.userName,
//               userImage: widget.userImage,
//             ));
//           },
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(widget.userImage ?? ''),
//               ),
//               SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(widget.userName ?? ''),
//                   Text(
//                     'Online',
//                     style: h5.copyWith(color: AppColors.secondaryOrangeColor),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
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
//       body: Obx(() => Column(
//         children: [
//           Expanded(
//             child: controller.isLoading.value
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//               controller: _scrollController, // Attach ScrollController
//               padding: EdgeInsets.all(16),
//               itemCount: controller.messageList.length,
//               itemBuilder: (context, index) {
//                 final message = controller.messageList[index];
//                 final isSender =
//                     message.sender == controller.getCurrentUserId();
//                 return _buildChatBubble(
//                   message: message.text ?? '',
//                   isSender: isSender,
//                   time: _formatTime(message.createdAt),
//                 );
//               },
//             ),
//           ),
//           _buildMessageInput(
//             controller: controller,
//             messageController: messageController,
//             chatId: widget.chatId,
//             receiverId: widget.receiverId, // Pass receiverId
//           ),
//         ],
//       )),
//     );
//   }
//
//   Widget _buildChatBubble({
//     required String message,
//     required bool isSender,
//     required String time,
//   }) {
//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4),
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isSender ? AppColors.secondaryOrangeColor : AppColors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(12),
//             topRight: Radius.circular(12),
//             bottomLeft: isSender ? Radius.circular(12) : Radius.zero,
//             bottomRight: isSender ? Radius.zero : Radius.circular(12),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment:
//           isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(
//               message,
//               style: h4.copyWith(
//                   color: isSender ? AppColors.white : AppColors.black),
//             ),
//             sh5,
//             Text(
//               time,
//               style: h6.copyWith(
//                   color: isSender ? AppColors.white : AppColors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMessageInput({
//     required ChatsController controller,
//     required TextEditingController messageController,
//     required String? chatId,
//     required String? receiverId, // Added receiverId parameter
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.borderColor),
//               borderRadius: BorderRadius.circular(12),
//               color: AppColors.white,
//             ),
//             child: IconButton(
//               icon: Image.asset(AppImages.fileAttachment, scale: 4),
//               onPressed: () {},
//             ),
//           ),
//           sw8,
//           Expanded(
//             child: CustomTextField(
//               controller: messageController,
//               hintText: "Message",
//               borderColor: AppColors.black,
//               sufIcon: IconButton(
//                 icon: Image.asset(
//                   AppImages.send,
//                   scale: 4,
//                 ),
//                 onPressed: () {
//                   if (messageController.text.trim().isNotEmpty &&
//                       chatId != null &&
//                       receiverId != null) {
//                     controller.sendMessage(chatId, messageController.text.trim(), receiverId);
//                     messageController.clear();
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _formatTime(DateTime? dateTime) {
//     if (dateTime == null) return '';
//     final time = TimeOfDay.fromDateTime(dateTime);
//     return time.format(Get.context!);
//   }
// }
//
// extension ChatsControllerExtension on ChatsController {
//   String? getCurrentUserId() {
//     String token = LocalStorage.getData(key: AppConstant.token);
//     if (token.isNotEmpty) {
//       Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
//       return decodedToken['id'] ?? decodedToken['_id'];
//     }
//     return null;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:tails_date/app/modules/chats/views/message_settings_view.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../../../common/app_color/app_colors.dart';
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/app_text_style/styles.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../../../common/widgets/custom_textfield.dart';
// import '../controllers/chats_controller.dart';
//
// class MessageView extends StatefulWidget {
//   final String? chatId;
//   final String? userName;
//   final String? userImage;
//
//   const MessageView({
//     super.key,
//     this.chatId,
//     this.userImage,
//     this.userName,
//   });
//
//   @override
//   State<MessageView> createState() => _MessageViewState();
// }
//
// class _MessageViewState extends State<MessageView> {
//   final ChatsController controller = Get.find<ChatsController>();
//   final TextEditingController messageController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.chatId != null) {
//       controller.setCurrentChatId(widget.chatId!);
//       controller.fetchMessageBody(widget.chatId!);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         titleSpacing: 0,
//         title: GestureDetector(
//           onTap: () {
//             Get.to(() => MessageSettingsView(
//               userName: widget.userName,
//               userImage: widget.userImage,
//             ));
//           },
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: widget.userImage != null
//                     ? NetworkImage(widget.userImage!)
//                     : null,
//               ),
//               SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(widget.userName ?? ''),
//                   Text('Online',
//                       style:
//                       h5.copyWith(color: AppColors.secondaryOrangeColor)),
//                 ],
//               ),
//             ],
//           ),
//         ),
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
//       body: Obx(() => Column(
//         children: [
//           Expanded(
//             child: controller.messageBody.isEmpty
//                 ? Center(child: Text('No messages', style: TextStyle(fontSize: 20, color: Colors.black)))
//                 : ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: controller.messageBody.length,
//               itemBuilder: (context, index) {
//                 final message = controller.messageBody[index];
//                 final isSender =
//                     message.sender == controller.getCurrentUserId();
//                 return _buildChatBubble(
//                   message: message.text ?? '',
//                   isSender: isSender,
//                   time: _formatTime(message.createdAt),
//                 );
//               },
//             ),
//           ),
//           _buildMessageInput(
//             controller: controller,
//             messageController: messageController,
//             chatId: widget.chatId,
//           ),
//         ],
//       )),
//     );
//   }
//
//   Widget _buildChatBubble({
//     required String message,
//     required bool isSender,
//     required String time,
//   }) {
//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4),
//         padding: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isSender ? AppColors.secondaryOrangeColor : AppColors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(12),
//             topRight: Radius.circular(12),
//             bottomLeft: isSender ? Radius.circular(12) : Radius.zero,
//             bottomRight: isSender ? Radius.zero : Radius.circular(12),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment:
//           isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(
//               message,
//               style: h4.copyWith(
//                   color: isSender ? AppColors.white : AppColors.black),
//             ),
//             sh5,
//             Text(
//               time,
//               style: h6.copyWith(
//                   color: isSender ? AppColors.white : AppColors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMessageInput({
//     required ChatsController controller,
//     required TextEditingController messageController,
//     required String? chatId,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.borderColor),
//               borderRadius: BorderRadius.circular(12),
//               color: AppColors.white,
//             ),
//             child: IconButton(
//               icon: Image.asset(AppImages.fileAttachment, scale: 4),
//               onPressed: () {},
//             ),
//           ),
//           sw8,
//           Expanded(
//             child: CustomTextField(
//               controller: messageController,
//               hintText: "Message",
//               borderColor: AppColors.black,
//               sufIcon: IconButton(
//                 icon: Image.asset(
//                   AppImages.send,
//                   scale: 4,
//                 ),
//                 onPressed: () {
//                   if (messageController.text.trim().isNotEmpty &&
//                       chatId != null) {
//                     controller.sendMessage(chatId, messageController.text.trim());
//                     messageController.clear();
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _formatTime(DateTime? dateTime) {
//     if (dateTime == null) return '';
//     final time = TimeOfDay.fromDateTime(dateTime);
//     return time.format(Get.context!);
//   }
// }