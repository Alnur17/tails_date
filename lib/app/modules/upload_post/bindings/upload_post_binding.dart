import 'package:get/get.dart';

import '../controllers/upload_post_controller.dart';

class UploadPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadPostController>(
      () => UploadPostController(),
    );
  }
}
