import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:tails_date/app/modules/home/views/report_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/widgets/custom_button.dart';
import 'package:tails_date/common/app_text_style/styles.dart';
import 'package:tails_date/common/widgets/custom_popup_menu_button.dart';
import 'package:tails_date/app/modules/profile/views/buy_star_view.dart';
import 'package:tails_date/app/modules/profile/views/send_stars_view.dart';

class GuestUserPostCard extends StatelessWidget {
  final String userName;
  final String postId;
  final String location;
  final String profileImage;
  final List<String> images;
  final String timeAgo;
  final String description;
  final int likeCount;
  final VoidCallback? onAddFriend;
  final VoidCallback onBookmark;
  final VoidCallback onReaction;
  final VoidCallback onOtherProfileTap;
  final VoidCallback? onNotInterestedTap;
  final Widget? popupMenuButton;
  final bool showAddFriendButton;

  const GuestUserPostCard({
    super.key,
    required this.userName,
    required this.location,
    required this.profileImage,
    required this.images,
    required this.timeAgo,
    required this.description,
    required this.likeCount,
    this.onAddFriend,
    this.popupMenuButton,
    this.showAddFriendButton = true,
    required this.postId,
    required this.onBookmark,
    required this.onReaction,
    required this.onOtherProfileTap,
    this.onNotInterestedTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: onOtherProfileTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileImage),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: h3,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.location,
                              scale: 4,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                location,
                                style: h5.copyWith(color: AppColors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // if (!isMe)
                      //   CustomButton(
                      //     width: 90,
                      //     text: 'Add_Friend'.tr,
                      //     onPressed: onAddFriend!,
                      //     height: 30,
                      //     backgroundColor: AppColors.black,
                      //     borderRadius: 8,
                      //     textStyle: h6.copyWith(color: AppColors.white),
                      //   ),
                      // const SizedBox(width: 8),
                      popupMenuButton ??
                          CustomPopupMenuButton(
                            items: [
                              PopupMenuItemData(
                                value: 'Report_Content'.tr,
                                label: 'Report_Content'.tr,
                                onSelected: () {
                                  Get.to(() => ReportView(postId),
                                      transition: Transition.downToUp);
                                },
                              ),
                              PopupMenuItemData(isDivider: true),
                              PopupMenuItemData(
                                value: 'Not_Interested'.tr,
                                label: 'Not_Interested'.tr,
                                onSelected: onNotInterestedTap,
                              ),
                            ],
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              description,
              style: h6,
            ),
          ),
          // Media Section
          if (images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: images.length == 1
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  images.first,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  scale: 4,
                ),
              )
                  : images.length == 5
                  ? Column(
                children: [
                  Row(
                    children: images.sublist(0, 2).map((image) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              image,
                              fit: BoxFit.cover,
                              height: 140,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: images.sublist(2, 5).map((image) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              image,
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 0.9,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          // Footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(timeAgo, style: h6),
                const Spacer(),
                _buildIcon(
                  AppImages.heart,
                  likeCount,
                  onTap: onReaction,
                ),
                _buildIcon(AppImages.star, null,
                    onTap: () => showStarBuyDialog(context)),
                _buildIcon(
                  AppImages.bookmark,
                  null,
                  onTap: onBookmark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String image, int? count, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(image, scale: 4),
          if (count != null) ...[
            const SizedBox(width: 5),
            Text('$count', style: h6),
          ],
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  void showStarBuyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.gradientColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Support_What_You_Love'.tr, style: h3, textAlign: TextAlign.center),
                  Image.asset(AppImages.starImage, scale: 4),
                  const SizedBox(height: 8),
                  CustomButton(
                    onPressed: () => Get.to(() => BuyStarView()),
                    text: 'Buy_Star_Button'.tr,
                    backgroundColor: AppColors.white,
                    textStyle: h3.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text('Or'.tr, style: h3),
                  const SizedBox(height: 8),
                  CustomButton(
                    onPressed: () => Get.to(() => SendStarsView(id: postId)),
                    text: 'Send_Stars'.tr,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}