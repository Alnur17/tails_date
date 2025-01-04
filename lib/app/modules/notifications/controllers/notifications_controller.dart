import 'package:get/get.dart';

class NotificationsController extends GetxController {
  RxInt activeTab = 0.obs;

  void toggleTab(int tabIndex) {
    activeTab.value = tabIndex;
  }
}
