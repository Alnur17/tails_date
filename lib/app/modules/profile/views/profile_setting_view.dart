
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tails_date/app/modules/privacy_policy/views/privacy_policy_view.dart';
import 'package:tails_date/app/modules/profile/views/change_password_view.dart';
import 'package:tails_date/app/modules/profile/views/star_balance_view.dart';
import 'package:tails_date/app/modules/profile/views/subscription_plan_view.dart';
import 'package:tails_date/app/modules/terms_of_services/views/terms_of_services_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_text_style/styles.dart';

import '../../../../common/app_images/app_images.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_container.dart';

class ProfileSettingView extends GetView {
  const ProfileSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Profile Setting'),
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
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.white,
            ),
            title: Text('Piku_The_King'),
            subtitle: Row(
              children: [
                Image.asset(
                  AppImages.location,
                  scale: 4,
                ),
                sw12,
                Text('23/1-A, Florida, USA.')
              ],
            ),
          ),
          sh16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CustomContainer(
                  text: 'Change Password',
                  imagePath: AppImages.unLock,
                  onTap: () {
                    Get.to(() => ChangePasswordView());
                  },
                ),
                sh16,
                CustomContainer(
                  onTap: () {
                    Get.to(() => PrivacyPolicyView());
                  },
                  text: 'Privacy Policy',
                  imagePath: AppImages.adminSettings,
                ),
                sh16,
                CustomContainer(
                  onTap: () {
                    Get.to(() => TermsOfServicesView());
                  },
                  text: 'Terms of Services',
                  imagePath: AppImages.adminSettings,
                ),
                sh16,
                CustomContainer(
                  onTap: () {
                    Get.to(() => SubscriptionPlanView());
                  },
                  text: 'Payment System',
                  imagePath: AppImages.payment,
                ),
                sh16,
                CustomContainer(
                  onTap: () {
                    Get.to(() => StarBalanceView());
                  },
                  text: 'Star Balance',
                  imagePath: AppImages.star,
                ),
                sh16,
                CustomContainer(
                  onTap: () {},
                  text: 'App Language',
                  imagePath: AppImages.language,
                ),
                sh16,
                CustomContainer(
                  onTap: () {
                    showDeleteAccountDialog(context);
                  },
                  text: 'Delete Account',
                  imagePath: AppImages.accountDelete,
                ),
                sh16,
                CustomContainer(
                  onTap: () {},
                  text: 'Log out',
                  textStyle: h3.copyWith(
                    color: AppColors.red,
                  ),
                  imagePath: AppImages.logoutTwo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future showDeleteAccountDialog(BuildContext context) {
    return Get.defaultDialog(
      title: "Delete Your Account",
      titlePadding: EdgeInsets.only(top: 16),
      backgroundColor: AppColors.white,
      radius: 8,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              "Are you sure you want to delete your account?",
              style: h4.copyWith(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          sh20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.white,
                  side: BorderSide(color: AppColors.red),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4),
                      bottom: Radius.circular(4),
                    ),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: h2.copyWith(fontSize: 12, color: AppColors.red),
                ),
              ),
              sw10,
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 45, vertical: 10), // Box-like padding
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4),
                      bottom: Radius.circular(4),
                    ),
                  ),
                  side: BorderSide.none,
                ),
                child: Text(
                  "Delete",
                  style: h2.copyWith(fontSize: 12, color: AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
