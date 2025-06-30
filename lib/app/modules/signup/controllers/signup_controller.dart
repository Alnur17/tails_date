import 'package:get/get.dart';

class SignupController extends GetxController {
  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isCheckboxVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.toggle();
  }

  void toggleCheckboxVisibility() {
    isCheckboxVisible.toggle();

  }

}
