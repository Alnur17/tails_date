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
          'Report',
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
                'Why are you reporting this post?',
                style: h3,
              ),
              sh20,
              CustomCheckboxRow(
                value: controller.reasonOptions['Bullying, harassment or abuse']!.value,
                text: 'Bullying, harassment or abuse',
                onChanged: (value) => controller.reasonOptions['Bullying, harassment or abuse']!.value = value!,
              ),
              sh16,
              CustomCheckboxRow(
                value: controller.reasonOptions['Violent, hateful or disturbing content']!.value,
                text: 'Violent, hateful or disturbing content',
                onChanged: (value) => controller.reasonOptions['Violent, hateful or disturbing content']!.value = value!,
              ),
              sh16,
              CustomCheckboxRow(
                value: controller.reasonOptions['Block this user']!.value,
                text: 'Block this user',
                onChanged: (value) => controller.reasonOptions['Block this user']!.value = value!,
              ),
              sh16,
              CustomCheckboxRow(
                value: controller.reasonOptions['Others Reason']!.value,
                text: 'Others Reason',
                onChanged: (value) {
                  controller.reasonOptions['Others Reason']!.value = value!;
                  if (!value) controller.reasonController.clear(); // Clear text when deselected
                },
              ),
              sh30,
              if (controller.reasonOptions['Others Reason']!.value)
                CustomTextField(
                  height: 250,
                  controller: controller.reasonController,
                  hintText: 'Write Something here......',
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
                text: controller.isLoading.value ? 'Submitting...' : 'Submit',
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