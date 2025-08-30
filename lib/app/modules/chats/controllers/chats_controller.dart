import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/model/message_body_model.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';
import 'package:tails_date/common/helper/local_store.dart';
import '../../../../Services/socket_services.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_chat_model.dart';

class ChatsController extends GetxController {
  var chatsList = <AllChatDatum>[].obs;
  var apiMessageList = <MessageBodyDatum>[].obs;
  var message = MessageBodyModel().obs;
  var messageList = <MessageBodyDatum>[].obs;

  final SocketService socketService = Get.put(SocketService());

  var inProgress = false.obs;
  var friends = AllChatModel().obs;
  var friendList = <AllChatDatum>[].obs;
  var isLoading = false.obs;
  String? errorMessage;

  @override
  void onInit() {
    super.onInit();
    fetchAllChats();
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
        chatsList.value = chatModel.data ?? [];
        print('Chat list length ${chatsList.value.length}');

        friendList.clear();
        friends.value = chatModel;
        friendList.addAll(friends.value.data ?? []);
        print('Chat list length AFTER ADD ${friendList.length}');

        socketService.socketFriendList.clear();

        for (final friend in friendList) {
          try {
            if (friend.lastMessage.isEmpty) {
              print("⚠ Skipping chat ${friend.id}, no last message");
              continue;
            }

            if (friend.participants.length < 2) {
              print("⚠ Skipping chat ${friend.id}, not enough participants");
              continue;
            }

            socketService.socketFriendList.add({
              "receiverId": friend.lastMessage.first.receiver,
              "name": friend.participants[0].name,
              "profileImage": friend.participants[0].image,
              "lastMessage": friend.lastMessage.first.text ?? '',
              "lastMessageTime": friend.lastMessage.first.createdAt ?? DateTime.now(),
              "isSeen": friend.lastMessage.first.seen ?? false,
            });

            print("✅ Added chat ${friend.id}");
          } catch (e) {
            print("❌ Error processing chat ${friend.id}: $e");
          }
        }

        print("📦 socket friendList length is : ${socketService.socketFriendList.length}");
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
        params: {"limit": "1000000"},
        api: Api.getMessage(chatId),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final result = await BaseClient.handleResponse(response);
      final messageBodyModel = MessageBodyModel.fromJson(result);

      if (messageBodyModel.success == true && messageBodyModel.data != null) {
        print('My chat data is done');
        print(messageBodyModel);

        message.value = messageBodyModel;
        apiMessageList.value = messageBodyModel.data!.data;
        messageList
          ..clear()
          ..addAll(apiMessageList);

        print('📦 Messages loaded from API: ${messageList.length}');

        socketService.messageList.clear();

        for (final msg in messageList) {
          try {
            socketService.messageList.add({
              "id": msg.id.toString(),
              "text": msg.text ?? '',
              "seen": msg.seen,
              "senderId": msg.sender,
              "receiverId": msg.receiver,
              "chat": msg.chat.toString(),
              "createdAt": msg.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
            });
          } catch (e) {
            print("❌ Error adding message ${msg.id}: $e");
          }
        }
      } else {
        Get.snackbar(
          'Error',
          messageBodyModel.message ?? 'Failed to fetch messages',
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}