import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/controllers/chats_controller.dart';
import 'package:tails_date/app/modules/chats/views/message_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';

import '../../../../common/size_box/custom_sizebox.dart';

class ChatsView extends StatelessWidget {
  final ChatsController controller = Get.put(ChatsController());

  ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: const Text('Chats'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomTextField(
              preIcon: Image.asset(
                AppImages.searchTwo,
                scale: 4,
              ),
              hintText: 'Search by name',
            ),
          ),
          sh16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Active Now',
              style: h2.copyWith(fontSize: 20),
            ),
          ),
          sh12,
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => Stack(
                children: [
                  Container(
                    height: 60,
                    width: 65,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.white,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          sh8,
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index == controller.users.length - 1 ? 20 : 0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(user['picture']['thumbnail']),
                      ),
                      title: Text(
                          '${user['name']['first']} ${user['name']['last']}'),
                      titleTextStyle: h2.copyWith(fontSize: 20),
                      subtitle: const Text(
                          'Hello, I really like your photo about...'),
                      trailing: const Text('12:50'),
                      onTap: () {
                        Get.to(() => MessageView(user: user));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
