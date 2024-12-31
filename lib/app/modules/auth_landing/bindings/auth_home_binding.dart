import 'package:get/get.dart';

import '../controllers/auth_home_controller.dart';

class AuthLandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthHomeController>(
      () => AuthHomeController(),
    );
  }
}
