import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/common/app_color/app_colors.dart';

import '../controllers/chats_controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('ChatsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChatsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
