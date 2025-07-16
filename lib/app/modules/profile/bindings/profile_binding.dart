import 'package:get/get.dart';

import 'package:tails_date/app/modules/profile/controllers/buy_star_controller.dart';
import 'package:tails_date/app/modules/profile/controllers/collections_controller.dart';
import 'package:tails_date/app/modules/profile/controllers/conditions_controller.dart';
import 'package:tails_date/app/modules/profile/controllers/my_friends_controller.dart';
import 'package:tails_date/app/modules/profile/controllers/send_stars_controller.dart';
import 'package:tails_date/app/modules/profile/controllers/subscription_plan_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollectionsController>(
      () => CollectionsController(),
    );
    Get.lazyPut<MyFriendsController>(
      () => MyFriendsController(),
    );
    Get.lazyPut<BuyStarController>(
      () => BuyStarController(),
    );
    Get.lazyPut<ConditionsController>(
      () => ConditionsController(),
    );
    Get.lazyPut<SubscriptionPlanController>(
      () => SubscriptionPlanController(),
    );
    Get.lazyPut<SendStarsController>(
      () => SendStarsController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
