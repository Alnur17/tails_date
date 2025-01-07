import 'package:get/get.dart';

import 'package:tails_date/app/modules/home/controllers/my_search_controller.dart';
import 'package:tails_date/app/modules/home/controllers/story_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySearchController>(
      () => MySearchController(),
    );
    Get.lazyPut<StoryController>(
      () => StoryController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
