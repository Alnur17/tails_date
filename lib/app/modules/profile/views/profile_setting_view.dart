// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:tails_date/app/modules/login/views/login_view.dart';
// import 'package:tails_date/app/modules/privacy_policy/views/privacy_policy_view.dart';
// import 'package:tails_date/app/modules/profile/views/change_password_view.dart';
// import 'package:tails_date/app/modules/profile/views/collections_view.dart';
// import 'package:tails_date/app/modules/profile/views/star_balance_view.dart';
// import 'package:tails_date/app/modules/profile/views/subscription_plan_view.dart';
// import 'package:tails_date/app/modules/terms_of_services/views/terms_of_services_view.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/app_text_style/styles.dart';
//
// import '../../../../common/app_constant/app_constant.dart';
// import '../../../../common/app_images/app_images.dart';
// import '../../../../common/helper/local_store.dart';
// import '../../../../common/size_box/custom_sizebox.dart';
// import '../../../../common/widgets/custom_container.dart';
// import '../controllers/profile_controller.dart';
//
// class ProfileSettingView extends StatefulWidget {
//   final String profileImage;
//   final String name;
//   final String location;
//
//   const ProfileSettingView(
//       {super.key,
//       required this.profileImage,
//       required this.name,
//       required this.location});
//
//   @override
//   State<ProfileSettingView> createState() => _ProfileSettingViewState();
// }
//
// class _ProfileSettingViewState extends State<ProfileSettingView> {
//   final ProfileController profileController = Get.put(ProfileController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         backgroundColor: AppColors.mainColor,
//         title: const Text('Profile Setting'),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Image.asset(
//             AppImages.back,
//             scale: 4,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ListTile(
//               leading: CircleAvatar(
//                 radius: 25,
//                 backgroundColor: AppColors.white,
//                 backgroundImage: NetworkImage(widget.profileImage),
//               ),
//               title: Text(widget.name),
//               subtitle: Row(
//                 children: [
//                   Image.asset(
//                     AppImages.location,
//                     scale: 4,
//                   ),
//                   sw12,
//                   Text(widget.location)
//                 ],
//               ),
//             ),
//             sh16,
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     CustomContainer(
//                       text: 'Change Password',
//                       imagePath: AppImages.unLock,
//                       onTap: () {
//                         Get.to(() => ChangePasswordView());
//                       },
//                     ),
//                     sh16,
//                     CustomContainer(
//                       onTap: () {
//                         Get.to(() => PrivacyPolicyView());
//                       },
//                       text: 'Privacy Policy',
//                       imagePath: AppImages.adminSettings,
//                     ),
//                     sh16,
//                     CustomContainer(
//                       onTap: () {
//                         Get.to(() => TermsOfServicesView());
//                       },
//                       text: 'Terms of Services',
//                       imagePath: AppImages.adminSettings,
//                     ),
//                     sh16,
//                     CustomContainer(
//                       onTap: () {
//                         Get.to(() => SubscriptionPlanView());
//                       },
//                       text: 'Payment System',
//                       imagePath: AppImages.payment,
//                     ),
//                     sh16,
//                     CustomContainer(
//                       onTap: () {
//                         Get.to(() => StarBalanceView(
//                               starBalance: profileController
//                                       .profileData.value?.data?.starBalance ??
//                                   0,
//                             ));
//                       },
//                       text: 'Star Balance',
//                       imagePath: AppImages.star,
//                     ),
//                     sh16,
//                     CustomContainer(
//                       onTap: () {
//                         Get.to(() => CollectionsView());
//                       },
//                       text: 'Collections',
//                       imagePath: AppImages.bookmark,
//                     ),
//                     sh16,
//                     Container(
//                       padding: EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: AppColors.white),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('App Language', style: h3),
//                               Image.asset(AppImages.language, scale: 4),
//                             ],
//                           ),
//                           sh8,
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Image.asset(AppImages.checkBoxFilled, scale: 4),
//                               sw12,
//                               Text('English', style: h4),
//                               sw16,
//                               Image.asset(AppImages.checkBox, scale: 4),
//                               sw12,
//                               Text('Spanish', style: h4),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     sh16,
//                     CustomContainer(
//                       onTap: () {
//                         showDeleteAccountDialog(context);
//                       },
//                       text: 'Delete Account',
//                       imagePath: AppImages.accountDelete,
//                     ),
//                     sh16,
//                     CustomContainer(
//                       onTap: () {
//                         LocalStorage.removeData(key: AppConstant.token);
//                         Get.offAll(() => LoginView());
//                       },
//                       text: 'Log out',
//                       textStyle: h3.copyWith(
//                         color: AppColors.red,
//                       ),
//                       imagePath: AppImages.logoutTwo,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             sh16,
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future showDeleteAccountDialog(BuildContext context,) {
//     return Get.defaultDialog(
//       title: "Delete Your Account",
//       titlePadding: EdgeInsets.only(top: 16),
//       backgroundColor: AppColors.white,
//       radius: 8,
//       content: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16),
//             child: Text(
//               "Are you sure you want to delete your account? This action can not be undone!",
//               style: h4.copyWith(
//                 fontSize: 18,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           sh20,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               OutlinedButton(
//                 onPressed: () => Get.back(),
//                 style: TextButton.styleFrom(
//                   backgroundColor: AppColors.white,
//                   side: BorderSide(color: AppColors.red),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(4),
//                       bottom: Radius.circular(4),
//                     ),
//                   ),
//                 ),
//                 child: Text(
//                   "Cancel",
//                   style: h2.copyWith(fontSize: 12, color: AppColors.red),
//                 ),
//               ),
//               sw10,
//               OutlinedButton(
//                 onPressed: () {
//                   profileController.deleteAccount();
//                 },
//                 style: OutlinedButton.styleFrom(
//                   backgroundColor: AppColors.red,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 45, vertical: 10), // Box-like padding
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(4),
//                       bottom: Radius.circular(4),
//                     ),
//                   ),
//                   side: BorderSide.none,
//                 ),
//                 child: Text(
//                   "Delete",
//                   style: h2.copyWith(fontSize: 12, color: AppColors.white),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/login/views/login_view.dart';
import 'package:tails_date/app/modules/privacy_policy/views/privacy_policy_view.dart';
import 'package:tails_date/app/modules/profile/views/change_password_view.dart';
import 'package:tails_date/app/modules/profile/views/collections_view.dart';
import 'package:tails_date/app/modules/profile/views/star_balance_view.dart';
import 'package:tails_date/app/modules/profile/views/subscription_plan_view.dart';
import 'package:tails_date/app/modules/terms_of_services/views/terms_of_services_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/localization/localization_controller.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_container.dart';
import '../controllers/profile_controller.dart';

class ProfileSettingView extends StatefulWidget {
  final String profileImage;
  final String name;
  final String location;

  const ProfileSettingView(
      {super.key,
        required this.profileImage,
        required this.name,
        required this.location});

  @override
  State<ProfileSettingView> createState() => _ProfileSettingViewState();
}

class _ProfileSettingViewState extends State<ProfileSettingView> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController = Get.find<LocalizationController>();

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Profile_Setting_Title'.tr),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.white,
                backgroundImage: NetworkImage(widget.profileImage),
              ),
              title: Text(widget.name),
              subtitle: Row(
                children: [
                  Image.asset(
                    AppImages.location,
                    scale: 4,
                  ),
                  sw12,
                  Text(widget.location)
                ],
              ),
            ),
            sh16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomContainer(
                      text: 'Change_Password'.tr,
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
                      text: 'Privacy_Policy'.tr,
                      imagePath: AppImages.adminSettings,
                    ),
                    sh16,
                    CustomContainer(
                      onTap: () {
                        Get.to(() => TermsOfServicesView());
                      },
                      text: 'Terms_Of_Services'.tr,
                      imagePath: AppImages.adminSettings,
                    ),
                    sh16,
                    CustomContainer(
                      onTap: () {
                        Get.to(() => SubscriptionPlanView());
                      },
                      text: 'Payment_System'.tr,
                      imagePath: AppImages.payment,
                    ),
                    sh16,
                    CustomContainer(
                      onTap: () {
                        Get.to(() => StarBalanceView(
                          starBalance: profileController
                              .profileData.value?.data?.starBalance ??
                              0,
                        ));
                      },
                      text: 'Star_Balance'.tr,
                      imagePath: AppImages.star,
                    ),
                    sh16,
                    CustomContainer(
                      onTap: () {
                        Get.to(() => CollectionsView());
                      },
                      text: 'Collections'.tr,
                      imagePath: AppImages.bookmark,
                    ),
                    sh16,
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('App_Language'.tr, style: h3),
                              Image.asset(AppImages.language, scale: 4),
                            ],
                          ),
                          sh8,
                          Obx(
                                () => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    localizationController.changeLanguage('English');
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        localizationController.selectedLanguage.value == 'English'
                                            ? AppImages.checkBoxFilled
                                            : AppImages.checkBox,
                                        scale: 4,
                                      ),
                                      sw12,
                                      Text('English', style: h4),
                                    ],
                                  ),
                                ),
                                sh8,
                                GestureDetector(
                                  onTap: () {
                                    localizationController.changeLanguage('Spanish');
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        localizationController.selectedLanguage.value == 'Spanish'
                                            ? AppImages.checkBoxFilled
                                            : AppImages.checkBox,
                                        scale: 4,
                                      ),
                                      sw12,
                                      Text('Spanish', style: h4),
                                    ],
                                  ),
                                ),
                                sh8,
                                GestureDetector(
                                  onTap: () {
                                    localizationController.changeLanguage('French');
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        localizationController.selectedLanguage.value == 'French'
                                            ? AppImages.checkBoxFilled
                                            : AppImages.checkBox,
                                        scale: 4,
                                      ),
                                      sw12,
                                      Text('French', style: h4),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    sh16,
                    CustomContainer(
                      onTap: () {
                        showDeleteAccountDialog(context);
                      },
                      text: 'Delete_Account'.tr,
                      imagePath: AppImages.accountDelete,
                    ),
                    sh16,
                    CustomContainer(
                      onTap: () {
                        LocalStorage.removeData(key: AppConstant.token);
                        Get.offAll(() => LoginView());
                      },
                      text: 'Log_Out'.tr,
                      textStyle: h3.copyWith(
                        color: AppColors.red,
                      ),
                      imagePath: AppImages.logoutTwo,
                    ),
                  ],
                ),
              ),
            ),
            sh16,
          ],
        ),
      ),
    );
  }

  Future showDeleteAccountDialog(BuildContext context) {
    return Get.defaultDialog(
      title: "Delete_Account_Dialog_Title".tr,
      titlePadding: EdgeInsets.only(top: 16),
      backgroundColor: AppColors.white,
      radius: 8,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Text(
              "Delete_Account_Dialog_Content".tr,
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
                  "Cancel".tr,
                  style: h2.copyWith(fontSize: 12, color: AppColors.red),
                ),
              ),
              sw10,
              OutlinedButton(
                onPressed: () {
                  profileController.deleteAccount();
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 45, vertical: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4),
                      bottom: Radius.circular(4),
                    ),
                  ),
                  side: BorderSide.none,
                ),
                child: Text(
                  "Delete".tr,
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