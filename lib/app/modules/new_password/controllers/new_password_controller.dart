import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.toggle();
  }
}
