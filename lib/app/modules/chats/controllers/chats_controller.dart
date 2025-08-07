// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/chats/model/message_body_model.dart';
// import 'package:tails_date/common/app_constant/app_constant.dart';
// import 'package:tails_date/common/helper/local_store.dart';
// import 'package:tails_date/app/data/api.dart';
// import 'package:tails_date/app/data/base_client.dart';
// import '../../../../common/helper/socket_service.dart';
// import '../model/all_chat_model.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'dart:async';
//
// class ChatsController extends GetxController {
//   var chats = <AllChatDatum>[].obs;
//   var messageBody = <MessageBodyDatum>[].obs;
//   var isLoading = false.obs;
//   var currentChatId = ''.obs;
//   late SocketService _socketService;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _socketService = Get.find<SocketService>();
//     fetchAllChats();
//     ever(_socketService.messageBody, (messages) {
//       if (currentChatId.value.isNotEmpty) {
//         final filteredMessages = messages
//             .where((m) => m.chat == currentChatId.value)
//             .toList();
//         print('Updating messageBody for chatId ${currentChatId.value} with ${filteredMessages.length} messages');
//         messageBody.assignAll(filteredMessages);
//       } else {
//         print('No currentChatId set, skipping messageBody update');
//       }
//     });
//     ever(_socketService.updateLastMessage, (update) {
//       final chatId = update['chatId'] as String?;
//       final message = update['message'] as MessageBodyDatum?;
//       if (chatId != null && message != null) {
//         print('Updating lastMessage for chatId: $chatId');
//         _updateChatLastMessage(chatId, message);
//       }
//     });
//     Timer.periodic(Duration(seconds: 30), (timer) => fetchAllChats());
//   }
//
//   void setCurrentChatId(String chatId) {
//     print('Setting currentChatId: $chatId');
//     currentChatId.value = chatId;
//     final filteredMessages = _socketService.messageBody
//         .where((m) => m.chat == chatId)
//         .toList();
//     print('Initial messageBody filter for chatId $chatId: ${filteredMessages.length} messages');
//     messageBody.assignAll(filteredMessages);
//   }
//
//   void _updateChatLastMessage(String chatId, MessageBodyDatum message) {
//     final chatIndex = chats.indexWhere((chat) => chat.id == chatId);
//     if (chatIndex != -1) {
//       final lastMessage = LastMessage(
//         id: message.id,
//         sender: message.sender,
//         receiver: message.receiver,
//         chat: message.chat,
//         text: message.text,
//         seen: message.seen,
//         createdAt: message.createdAt,
//         updatedAt: message.updatedAt,
//         v: message.v,
//       );
//       final updatedChat = AllChatDatum(
//         id: chats[chatIndex].id,
//         participants: chats[chatIndex].participants,
//         lastMessage: [lastMessage, ...chats[chatIndex].lastMessage],
//       );
//       chats[chatIndex] = updatedChat;
//       chats.refresh();
//       print('Updated chats[$chatIndex].lastMessage with: ${lastMessage.text}');
//     } else {
//       print('Chat not found for chatId: $chatId');
//     }
//   }
//
//   Future<void> sendMessage(String chatId, String messageText) async {
//     String? userId = LocalStorage.getData(key: AppConstant.userId);
//     if (userId != null) {
//       String? receiverId = chats
//           .firstWhere(
//             (chat) => chat.id == chatId,
//         orElse: () => AllChatDatum(id: null, participants: [], lastMessage: []),
//       )
//           .participants
//           .firstWhere(
//             (participant) => participant.id != userId,
//         orElse: () => Participant(id: null, image: null, name: null),
//       )
//           .id;
//       if (receiverId != null) {
//         print('Sending message to chatId: $chatId, receiver: $receiverId');
//         _socketService.sendMessage(chatId, messageText, receiverId);
//       } else {
//         print('Receiver not found for chatId: $chatId');
//         Get.snackbar('Error', 'Receiver not found');
//       }
//     } else {
//       print('UserId is null');
//       Get.snackbar('Error', 'User not authenticated');
//     }
//   }
//
//   Future<void> fetchAllChats() async {
//     try {
//       isLoading.value = true;
//       String token = LocalStorage.getData(key: AppConstant.token);
//       print('Fetching all chats with token: $token');
//       final response = await BaseClient.getRequest(
//         api: Api.allChat,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       final result = await BaseClient.handleResponse(response);
//       print('All chats response: $result');
//       final chatModel = AllChatModel.fromJson(result);
//       if (chatModel.success == true) {
//         chats.value = chatModel.data;
//         print('Fetched ${chatModel.data.length} chats');
//       } else {
//         print('Failed to fetch chats: ${chatModel.message}');
//         Get.snackbar('Error', chatModel.message ?? 'Failed to fetch chats');
//       }
//     } catch (e) {
//       print('Error fetching chats: $e');
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> fetchMessageBody(String chatId) async {
//     try {
//       isLoading.value = true;
//       String token = LocalStorage.getData(key: AppConstant.token);
//       print('Fetching messages for chatId: $chatId with token: $token');
//       final response = await BaseClient.getRequest(
//         api: Api.getMessage(chatId),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       final result = await BaseClient.handleResponse(response);
//       print('API response: $result');
//       final messageBodyModel = MessageBodyModel.fromJson(result);
//       if (messageBodyModel.success == true && messageBodyModel.data != null) {
//         print('Fetched ${messageBodyModel.data!.data.length} messages');
//         messageBody.value = messageBodyModel.data!.data;
//         _socketService.messageBody.removeWhere((m) => m.chat == chatId);
//         _socketService.messageBody.addAll(messageBodyModel.data!.data);
//         print('Updated messageBody with ${messageBody.length} messages');
//       } else {
//         print('Failed to fetch messages: ${messageBodyModel.message}');
//         Get.snackbar('Error', messageBodyModel.message ?? 'Failed to fetch messages');
//       }
//     } catch (e) {
//       print('Error fetching messages: $e');
//       Get.snackbar('Error', 'Failed to load messages: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   String? getCurrentUserId() {
//     String token = LocalStorage.getData(key: AppConstant.token);
//     if (token.isNotEmpty) {
//       Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
//       return decodedToken['id'] ?? decodedToken['_id'];
//     }
//     return null;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }

// class ChatsController extends GetxController {
//   var chats = <AllChatDatum>[].obs;
//   var messageBody = <MessageBodyDatum>[].obs;
//   var isLoading = false.obs;
//   late SocketService _socketService;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _socketService = Get.put(SocketService());
//     fetchAllChats();
//     // Sync messageBody with SocketService
//     ever(_socketService.messageBody, (messages) {
//       messageBody.assignAll(messages);
//     });
//   }
//
//   Future<void> sendMessage(String chatId, String messageText) async {
//     String? userId = LocalStorage.getData(key: AppConstant.userId);
//     if (userId != null) {
//       // Find the receiver ID from the chats list (excluding the current user)
//       String? receiverId = chats.firstWhere(
//             (chat) => chat.id == chatId,
//         orElse: () => AllChatDatum(id: null, participants: [], lastMessage: []),
//       ).participants.firstWhere(
//             (participant) => participant.id != userId,
//         orElse: () => Participant(id: null, image: null, name: null),
//       ).id;
//       if (receiverId != null) {
//         _socketService.sendMessage(chatId, messageText, receiverId);
//       } else {
//         Get.snackbar('Error', 'Receiver not found');
//       }
//     }
//   }
//
//   Future<void> fetchAllChats() async {
//     try {
//       isLoading.value = true;
//       String token = LocalStorage.getData(key: AppConstant.token);
//
//       final response = await BaseClient.getRequest(
//         api: Api.allChat,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//       );
//       final result = await BaseClient.handleResponse(response);
//       final chatModel = AllChatModel.fromJson(result);
//       if (chatModel.success == true) {
//         chats.value = chatModel.data;
//       } else {
//         Get.snackbar('Error', chatModel.message ?? 'Failed to fetch chats');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> fetchMessageBody(String chatId) async {
//     try {
//       isLoading.value = true;
//       String token = LocalStorage.getData(key: AppConstant.token);
//
//       final response = await BaseClient.getRequest(
//         api: Api.getMessage(chatId),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//       );
//       final result = await BaseClient.handleResponse(response);
//       final messageBodyModel = MessageBodyModel.fromJson(result);
//       if (messageBodyModel.success == true && messageBodyModel.data != null) {
//         messageBody.value = messageBodyModel.data!.data;
//       } else {
//         Get.snackbar('Error', messageBodyModel.message ?? 'Failed to fetch messages');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   @override
//   void dispose() {
//     Get.delete<SocketService>();
//     super.dispose();
//   }
// }


import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/model/message_body_model.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';
import '../../../../common/helper/socket_service.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_chat_model.dart';

class ChatsController extends GetxController {
  var chatsList = <AllChatDatum>[].obs;
  var messageList = <MessageBodyDatum>[].obs;
  var isLoading = false.obs;
  late SocketService socketService;

  @override
  void onInit() async {
    super.onInit();
    await fetchAllChats();
    // Get the existing SocketService instance and update onNewMessage
    socketService = Get.find<SocketService>();
    socketService.onNewMessage = (message) {
      messageList.add(message);
      messageList.refresh();
    };
  }

  Future<void> fetchAllChats() async {
    try {
      isLoading.value = true;
      String token = LocalStorage.getData(key: AppConstant.token);

      final response = await BaseClient.getRequest(
        api: Api.allChat,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final result = await BaseClient.handleResponse(response);
      final chatModel = AllChatModel.fromJson(result);
      if (chatModel.success == true) {
        chatsList.value = chatModel.data;
      } else {
        Get.snackbar('Error', chatModel.message ?? 'Failed to fetch chats');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMessageBody(String chatId) async {
    try {
      isLoading.value = true;
      String token = LocalStorage.getData(key: AppConstant.token);

      final response = await BaseClient.getRequest(
        api: Api.getMessage(chatId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final result = await BaseClient.handleResponse(response);
      final messageBodyModel = MessageBodyModel.fromJson(result);
      if (messageBodyModel.success == true && messageBodyModel.data != null) {
        messageList.value = messageBodyModel.data!.data;
      } else {
        Get.snackbar('Error', messageBodyModel.message ?? 'Failed to fetch messages');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage(String chatId, String message, String receiverId) {
    if (message.trim().isNotEmpty) {
      socketService.sendMessage(chatId, message, receiverId);
    }
  }

  @override
  void onClose() {
    socketService.dispose();
    super.onClose();
  }
}


// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/chats/model/message_body_model.dart';
// import 'package:tails_date/common/app_constant/app_constant.dart';
// import 'package:tails_date/common/helper/local_store.dart';
// import '../../../../common/helper/socket_service.dart';
// import '../../../data/api.dart';
// import '../../../data/base_client.dart';
// import '../model/all_chat_model.dart';
//
// class ChatsController extends GetxController {
//   var chats = <AllChatDatum>[].obs;
//   var messageBody = <MessageBodyDatum>[].obs;
//   var isLoading = false.obs;
//   late SocketService socketService;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllChats();
//     socketService = SocketService(
//       onNewMessage: (message) {
//         messageBody.add(message);
//         messageBody.refresh();
//       },
//     );
//   }
//
//   Future<void> fetchAllChats() async {
//     try {
//       isLoading.value = true;
//       String token = LocalStorage.getData(key: AppConstant.token);
//
//       final response = await BaseClient.getRequest(
//         api: Api.allChat,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       final result = await BaseClient.handleResponse(response);
//       final chatModel = AllChatModel.fromJson(result);
//       if (chatModel.success == true) {
//         chats.value = chatModel.data;
//       } else {
//         Get.snackbar('Error', chatModel.message ?? 'Failed to fetch chats');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> fetchMessageBody(String chatId) async {
//     try {
//       isLoading.value = true;
//       String token = LocalStorage.getData(key: AppConstant.token);
//
//       final response = await BaseClient.getRequest(
//         api: Api.getMessage(chatId),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       final result = await BaseClient.handleResponse(response);
//       final messageBodyModel = MessageBodyModel.fromJson(result);
//       if (messageBodyModel.success == true && messageBodyModel.data != null) {
//         messageBody.value = messageBodyModel.data!.data;
//       } else {
//         Get.snackbar('Error', messageBodyModel.message ?? 'Failed to fetch messages');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void sendMessage(String chatId, String message, String receiverId) {
//     if (message.trim().isNotEmpty) {
//       socketService.sendMessage(chatId, message, receiverId);
//     }
//   }
//
//   //String? getCurrentUserId() {
//   //   String token = LocalStorage.getData(key: AppConstant.token);
//   //   if (token.isNotEmpty) {
//   //     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
//   //     return decodedToken['id'] ?? decodedToken['_id'];
//   //   }
//   //   return null;
//   // }
//
//   @override
//   void onClose() {
//     socketService.dispose();
//     super.onClose();
//   }
// }

// Future<void> sendMessage(String chatId, String text) async {
//   try {
//     isLoading.value = true;
//     String token = LocalStorage.getData(key: AppConstant.token);
//
//     final response = await BaseClient.postRequest(
//       api: Api.createChat,
//       body: jsonEncode({
//         'chat': chatId,
//         'text': text,
//       }),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
//     );
//     final result = await BaseClient.handleResponse(response);
//     final messageBodyModel = MessageBodyModel.fromJson(result);
//     if (messageBodyModel.success == true && messageBodyModel.data != null) {
//       messageBody.add(messageBodyModel.data!.data.last);
//     } else {
//       Get.snackbar('Error', messageBodyModel.message ?? 'Failed to send message');
//     }
//   } catch (e) {
//     Get.snackbar('Error', e.toString());
//   } finally {
//     isLoading.value = false;
//   }
// }