import 'dart:developer';

import 'package:get/get.dart';

class MessageSettingsController extends GetxController {
  RxBool isNotificationMuted = false.obs;

  void toggleNotificationMuted(value){
    isNotificationMuted.value = value;
    log('Mute Notification');
  }
}
