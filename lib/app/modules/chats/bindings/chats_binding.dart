import 'package:get/get.dart';

import 'package:tails_date/app/modules/chats/controllers/message_settings_controller.dart';

import '../controllers/chats_controller.dart';

class ChatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageSettingsController>(
      () => MessageSettingsController(),
    );
    Get.lazyPut<ChatsController>(
      () => ChatsController(),
    );
  }
}
