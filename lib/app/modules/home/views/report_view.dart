import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/widgets/custom_checkbox_row.dart';
import 'package:tails_date/common/widgets/custom_textfield.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  final String postId;
  const ReportView(this.postId, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Report_Title'.tr,
          style: h2,
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Why_Report_Post'.tr,
                style: h3,
              ),
              sh20,
              CustomCheckboxRow(
                value: controller.reasonOptions['Bullying_Harassment_Abuse'.tr]!.value,
                text: 'Bullying_Harassment_Abuse'.tr,
                onChanged: (value) => controller.reasonOptions['Bullying_Harassment_Abuse'.tr]!.value = value!,
              ),
              sh16,
              CustomCheckboxRow(
                value: controller.reasonOptions['Violent_Hateful_Disturbing'.tr]!.value,
                text: 'Violent_Hateful_Disturbing'.tr,
                onChanged: (value) => controller.reasonOptions['Violent_Hateful_Disturbing'.tr]!.value = value!,
              ),
              sh16,
              CustomCheckboxRow(
                value: controller.reasonOptions['Block_This_User'.tr]!.value,
                text: 'Block_This_User'.tr,
                onChanged: (value) => controller.reasonOptions['Block_This_User'.tr]!.value = value!,
              ),
              sh16,
              CustomCheckboxRow(
                value: controller.reasonOptions['Others_Reason'.tr]!.value,
                text: 'Others_Reason'.tr,
                onChanged: (value) {
                  controller.reasonOptions['Others_Reason'.tr]!.value = value!;
                  if (!value) controller.reasonController.clear(); // Clear text when deselected
                },
              ),
              sh30,
              if (controller.reasonOptions['Others_Reason'.tr]!.value)
                CustomTextField(
                  height: 250,
                  controller: controller.reasonController,
                  hintText: 'Write_Something_Here'.tr,
                ),
              if (controller.errorMessage.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    controller.errorMessage.value,
                    style: h5.copyWith(color: Colors.red),
                  ),
                ),
              sh24,
              CustomButton(
                text: controller.isLoading.value ? 'Submitting'.tr : 'Submit'.tr,
                onPressed: controller.isLoading.value
                    ? () {}
                    : () => controller.submitReport(postId),
              ),
            ],
          )),
        ),
      ),
    );
  }
}