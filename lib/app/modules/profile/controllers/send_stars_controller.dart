import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendStarsController extends GetxController {
  RxInt selectedAmount = 0.obs;
  TextEditingController customAmountController = TextEditingController();

  void selectAmount(int amount) {
    if (selectedAmount.value == amount) {
      // Deselect if the same amount is tapped again
      selectedAmount.value = 0;
      customAmountController.clear();
    } else {
      selectedAmount.value = amount;
      customAmountController.text = amount.toString();
    }
  }

  String getSelectedAmount() {
    return customAmountController.text;
  }

  @override
  void onClose() {
    customAmountController.dispose();
    super.onClose();
  }
}
