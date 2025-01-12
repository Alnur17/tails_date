import 'package:get/get.dart';

import '../controllers/terms_of_services_controller.dart';

class TermsOfServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsOfServicesController>(
      () => TermsOfServicesController(),
    );
  }
}
