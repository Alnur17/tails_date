import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/views/message_settings_view.dart';

import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/widgets/custom_textfelid.dart';

class MessageView extends StatefulWidget {
  final dynamic user;

  const MessageView({super.key, this.user});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "message": "OMG, your cat is the cutest thing ever! 🥰",
      "isSender": false,
      "time": "10:10",
    },
    {
      "message": "Is that Gultush in the latest photo?",
      "isSender": false,
      "time": "10:10",
    },
    {
      "message": "Haha, yes, that’s Gultush!",
      "isSender": true,
      "time": "10:15",
    },
    {
      "message":
          "He was having his “royal spa” moment during that photo. He loves being brushed!",
      "isSender": true,
      "time": "10:15",
    },
    {
      "message": "He looks so fluffy and relaxed!",
      "isSender": false,
      "time": "10:20",
    },
    {
      "message":
          "😍 I wish my cat was as chill during brushing—mine acts like it’s the end of the world. 😂",
      "isSender": false,
      "time": "10:20",
    },
    {
      "message": "LOL, 🤣🤣",
      "isSender": true,
      "time": "10:20",
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final String message = _messageController.text.trim();
    final String time = TimeOfDay.now().format(context);

    setState(() {
      _messages.add({
        "message": message,
        "isSender": true,
        "time": time,
      });
    });

    _messageController.clear();
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
            Get.to(() => MessageSettingsView());
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.user['picture']['thumbnail']),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${widget.user['name']['first']} ${widget.user['name']['last']}'),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildChatBubble(
                  message: message['message'],
                  isSender: message['isSender'],
                  time: message['time'],
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
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
          crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
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
              controller: _messageController,
              hintText: "Message",
              sufIcon: IconButton(
                icon: Image.asset(
                  AppImages.send,
                  scale: 4,
                ),
                onPressed: _sendMessage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
