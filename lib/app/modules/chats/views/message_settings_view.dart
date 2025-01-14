import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_list_tile.dart';
import '../controllers/message_settings_controller.dart';

class MessageSettingsView extends GetView<MessageSettingsController> {
  const MessageSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MessageSettingsController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Message Settings',
          style: h2,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back,scale: 4,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.white
          ),
          child: Column(
            children: [
              sh20,
              const CircleAvatar(
                radius: 85,
                backgroundImage: NetworkImage(AppImages.profileImage),
              ),
              sh24,
              Text(
                'Saiteja Pagadala',
                style: h3.copyWith(
                  fontSize: 22,
                ),
              ),
              sh24,
              Obx(
                    () {
                  return CustomListTile(
                    leadingImage: AppImages.unMute,
                    title: 'Mute Notification',
                    titleStyle: h3,
                    isSwitch: true,
                    switchValue: controller.isNotificationMuted.value,
                    onSwitchChanged: controller.toggleNotificationMuted,
                  );
                },
              ),
              CustomListTile(
                leadingImage: AppImages.logout,
                title: 'Block',
                titleStyle: h3.copyWith(color: AppColors.secondaryOrangeColor),
                onTap: () => log('Block'),
              ),
              sh16,
            ],
          ),
        ),
      ),
    );
  }
}
