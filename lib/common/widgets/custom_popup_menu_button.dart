import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/home/views/report_view.dart';
import 'package:tails_date/common/app_text_style/styles.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.black,
      icon: Image.asset(
        AppImages.threeDot,
        scale: 4,
      ),
      onSelected: (value) {
        switch (value) {
          case 'Report Content':
            Get.to(()=> ReportView(),transition: Transition.downToUp);
            break;
          case 'Not Interesting':
            print('Not Interesting');
            //Get.to(()=> ReportView());
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 20,
          value: 'Report Content',
          child: Text(
            'Report Content',
            style: h6.copyWith(color: AppColors.white),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 20,
          value: 'Not Interesting',
          child: Text(
            'Not Interesting',
            style: h6.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
