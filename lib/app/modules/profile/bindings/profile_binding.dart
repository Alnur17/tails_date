import 'package:get/get.dart';

import 'package:tails_date/app/modules/profile/controllers/send_stars_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendStarsController>(
      () => SendStarsController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
