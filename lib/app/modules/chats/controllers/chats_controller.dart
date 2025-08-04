import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/model/message_body_model.dart';
import 'package:tails_date/common/app_constant/app_constant.dart';

import '../../../../common/helper/local_store.dart';
import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../model/all_chat_model.dart';

class ChatsController extends GetxController {
  var chats = <AllChatDatum>[].obs;
  var messageBody = <MessageBodyDatum>[].obs;
  var isLoading = false.obs;

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
          'Authorization': 'Bearer $token'
        },
      );
      final result = await BaseClient.handleResponse(response);
      final chatModel = AllChatModel.fromJson(result);
      if (chatModel.success == true) {
        chats.value = chatModel.data;
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
          'Authorization': 'Bearer $token'
        },
      );
      final result = await BaseClient.handleResponse(response);
      final messageBodyModel = MessageBodyModel.fromJson(result);
      if (messageBodyModel.success == true && messageBodyModel.data != null) {
        messageBody.value = messageBodyModel.data!.data;
      } else {
        Get.snackbar('Error', messageBodyModel.message ?? 'Failed to fetch messages');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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
}