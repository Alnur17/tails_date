import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tails_date/app/modules/chats/views/message_settings_view.dart';
import 'package:intl/intl.dart';

import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../Services/socket_services.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/helper/socket_service.dart';
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
  final SocketService socketService = Get.put(SocketService());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool isSending = false;
  bool isTextEmpty = true;
  String updatesenderId = '';
  String updatereceiverId = '';
  late String senderId;
  late StreamSubscription messageListSubscription;

  @override
  void initState() {
    super.initState();
    // Initialize senderId and socket connection
    senderId = LocalStorage.getData(key: AppConstant.userId) ?? '';
    if (widget.chatId != null) {
      print('Sender ID: $senderId');
      print('Receiver ID: ${widget.receiverId}');
      socketService.messageList.clear(); // Clear previous messages for new chat
      controller.fetchMessageBody(widget.chatId!).then((_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToEnd();
        });
      });
    }
    socketService.init(); // Initialize the socket connection
    updatesenderId = senderId;
    updatereceiverId = widget.receiverId ?? '';

    // Listen for incoming messages from the socket
    socketService.sokect.on('receive-message::$senderId', (data) {
      print('Socket data received ...............');
      updatesenderId = data['sender'];
      updatereceiverId = data['receiver'];
      print('senderId: ${data['sender']}');
      print('receiverId: ${data['receiver']}');
      // Only add messages from the receiver to avoid duplicates
      if (data['sender'] != senderId) {
        _handleIncomingMessage(data);
      }
    });

    socketService.sokect
        .on('chat-list::${LocalStorage.getData(key: AppConstant.userId)}', (data) {
      print('Socket chatlist data received ...............');
      print(data);
      _handleIncomingFriends(data);
    });

    // Track text field content
    messageController.addListener(() {
      setState(() {
        isTextEmpty = messageController.text.trim().isEmpty;
      });
    });

    // Listen to messageList changes for auto-scroll
    messageListSubscription = socketService.messageList.listen((_) {
      if (mounted) {
        _scrollToEnd();
      }
    });

    // Initial scroll after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  @override
  void dispose() {
    // Clean up controllers, socket listeners, and subscription
    messageController.dispose();
    _scrollController.dispose();
    socketService.sokect.off('receive-message::$senderId');
    socketService.sokect.off('chat-list::${LocalStorage.getData(key: AppConstant.userId)}');
    messageListSubscription.cancel();
    super.dispose();
  }

  // Method to scroll to the end of the chat
  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients && mounted) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Method to handle incoming socket messages
  void _handleIncomingMessage(dynamic data) {
    if (data['createdAt'] == null) {
      data['createdAt'] = DateTime.now().toIso8601String();
    }
    socketService.messageList.add(data);
  }

  void _handleIncomingFriends(dynamic data) {}

  // Method to send messages
  Future<void> sendMessageBTN(
      String chatId, String text, String receiverId) async {
    if (_formKey.currentState!.validate() && !isSending && text.trim().isNotEmpty) {
      setState(() {
        isSending = true;
      });

      // Optimistically add the message locally
      final messageData = {
        'sender': senderId,
        'receiver': receiverId,
        'text': text,
        'createdAt': DateTime.now().toIso8601String(),
      };
      socketService.messageList.add(messageData);
      messageController.clear();
      // _scrollToEnd called via listen

      // Emit the message to the server
      socketService.sokect.emit('send-message', {
        'sender': senderId,
        'receiver': receiverId,
        'chat': chatId,
        'text': text,
      });

      setState(() {
        isSending = false;
      });
    } else if (text.trim().isEmpty) {
      Get.snackbar('Error', 'Message cannot be empty');
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
                      style: h5.copyWith(color: AppColors.green)),
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
                : socketService.messageList.isEmpty
                ? Center(child: Text('No Messages', style: h4))
                : ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: socketService.messageList.length,
              itemBuilder: (context, index) {
                final message = socketService.messageList[index];
                final isSender = (message['senderId'] ?? message['sender']) == widget.receiverId;
                return Align(
                  alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: isSender
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      _buildChatBubble(
                        message: message['text'] ?? '',
                        isSender: isSender,
                        time: _formatTime(DateTime.tryParse(
                            message['createdAt'] ?? '')),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(
            controller: controller,
            messageController: messageController,
            chatId: widget.chatId,
            receiverId: widget.receiverId,
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
    return Container(
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
    );
  }

  Widget _buildMessageInput({
    required ChatsController controller,
    required TextEditingController messageController,
    required String? chatId,
    required String? receiverId,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(color: AppColors.borderColor),
            //     borderRadius: BorderRadius.circular(12),
            //     color: AppColors.white,
            //   ),
            //   child: IconButton(
            //     icon: Image.asset(AppImages.fileAttachment, scale: 4),
            //     onPressed: () {},
            //   ),
            // ),
            // sw8,
            Expanded(
              child: CustomTextField(
                controller: messageController,
                hintText: "Message",
                borderColor: AppColors.black,
                sufIcon: isSending
                    ? CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondaryOrangeColor),
                )
                    : IconButton(
                  icon: Image.asset(
                    AppImages.send,
                    scale: 4,
                  ),
                  onPressed: isTextEmpty || chatId == null || receiverId == null
                      ? null
                      : () {
                    print('send message triggered');
                    sendMessageBTN(
                      chatId,
                      messageController.text.trim(),
                      receiverId,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('MMM d, HH:mm').format(dateTime);
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