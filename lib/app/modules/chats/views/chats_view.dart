import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/controllers/chats_controller.dart';
import 'package:tails_date/app/modules/chats/views/message_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/widgets/custom_textfelid.dart';

class ChatsView extends StatelessWidget {
  final ChatsController controller = Get.put(ChatsController());

  ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(scrolledUnderElevation: 0,
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
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CustomTextField(
              preIcon: Image.asset(
                AppImages.search,
                scale: 4,
              ),
              hintText: 'Search by name or location',
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['picture']['thumbnail']),
                    ),
                    title: Text('${user['name']['first']} ${user['name']['last']}'),
                    subtitle: const Text('Hello, I really like your photo about...'),
                    trailing: const Text('12:50'),
                    onTap: () {
                      Get.to(() => MessageView(user: user));
                    },
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
