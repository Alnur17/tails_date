import 'package:get/get.dart';

import '../controllers/free_trial_controller.dart';

class FreeTrialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreeTrialController>(
      () => FreeTrialController(),
    );
  }
}
