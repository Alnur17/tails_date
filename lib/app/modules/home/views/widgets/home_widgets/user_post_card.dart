// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:tails_date/app/modules/home/views/report_view.dart';
// import 'package:tails_date/common/app_color/app_colors.dart';
// import 'package:tails_date/common/app_images/app_images.dart';
// import 'package:tails_date/common/size_box/custom_sizebox.dart';
// import 'package:tails_date/common/widgets/custom_button.dart';
//
// import '../../../../../../common/app_text_style/styles.dart';
// import '../../../../../../common/widgets/custom_popup_menu_button.dart';
// import '../../../../profile/views/buy_star_view.dart';
// import '../../../../profile/views/send_stars_view.dart';
//
// class UserPostCard extends StatelessWidget {
//   final String userName;
//   final String location;
//   final String profileImage;
//   final List<String> images;
//   final String timeAgo;
//   final String description;
//   final int likeCount;
//   final VoidCallback? onAddFriend;
//   final Widget? popupMenuButton;
//   final bool showAddFriendButton;
//
//   const UserPostCard({
//     super.key,
//     required this.userName,
//     required this.location,
//     required this.profileImage,
//     required this.images,
//     required this.timeAgo,
//     required this.description,
//     required this.likeCount,
//     this.onAddFriend,
//     this.popupMenuButton,
//     this.showAddFriendButton = true, // Default to showing the button
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.black26),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(profileImage),
//                   radius: 20,
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         userName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Image.asset(
//                             AppImages.location,
//                             scale: 4,
//                           ),
//                           const SizedBox(width: 5),
//                           Expanded(
//                             child: Text(
//                               location,
//                               style: const TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 14,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 // Buttons in Row
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Show the "Add Friend" button only if enabled
//                     if (showAddFriendButton)
//                       CustomButton(
//                         width: 90,
//                         text: 'Add friend',
//                         onPressed: onAddFriend!,
//                         height: 30,
//                         backgroundColor: AppColors.black,
//                         borderRadius: 8,
//                         textStyle: h6.copyWith(color: AppColors.white),
//                       ),
//                     const SizedBox(width: 8),
//                     popupMenuButton ??
//                         CustomPopupMenuButton(
//                           items: [
//                             PopupMenuItemData(
//                               value: 'Report Content',
//                               label: 'Report Content',
//                               onSelected: () {
//                                 Get.to(
//                                   () => ReportView(),
//                                   transition: Transition.downToUp,
//                                 );
//                               },
//                             ),
//                             PopupMenuItemData(isDivider: true),
//                             PopupMenuItemData(
//                               value: 'Not Interested',
//                               label: 'Not Interested',
//                               onSelected: () {
//                                 log('Not Interested selected');
//                               },
//                             ),
//                           ],
//                         ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Description
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Text(
//               description,
//               style: h6,
//             ),
//           ),
//           // Media Section
//           if (images.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: images.length == 1
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         images.first,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         height: 300,
//                         scale: 4,
//                       ),
//                     )
//                   : GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2, // 2 items per row
//                         crossAxisSpacing: 4,
//                         mainAxisSpacing: 4,
//                       ),
//                       itemCount: images.length,
//                       itemBuilder: (context, index) {
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             images[index],
//                             fit: BoxFit.cover,
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           // Footer
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Row(
//               children: [
//                 Text(
//                   timeAgo,
//                   style: h6,
//                 ),
//                 const Spacer(),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Image.asset(
//                     AppImages.heart,
//                     scale: 4,
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   '$likeCount',
//                   style: h6,
//                 ),
//                 const SizedBox(width: 16),
//                 GestureDetector(
//                   onTap: () {
//                     showStarBuyDialog(context);
//                   },
//                   child: Image.asset(
//                     AppImages.star,
//                     scale: 4,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 GestureDetector(
//                   onTap: () {
//                     _showShareModal(context);
//                   },
//                   child: Image.asset(
//                     AppImages.share,
//                     scale: 4,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Image.asset(
//                     AppImages.bookmark,
//                     scale: 4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void showStarBuyDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: AppColors.gradientColor,
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Support what you love! 🌟 Send stars to help creators earn and grow their passion.',
//                     style: h3,
//                     textAlign: TextAlign.center,
//                   ),
//                   Image.asset(
//                     AppImages.starImage,
//                     scale: 4,
//                   ),
//                   const SizedBox(height: 8),
//                   CustomButton(
//                     onPressed: () {
//                       Get.to(() => BuyStarView());
//                     },
//                     text: "Buy Star 🌟",
//                     backgroundColor: AppColors.white,
//                     textStyle: h3.copyWith(
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text('OR', style: h3),
//                   const SizedBox(height: 8),
//                   CustomButton(
//                     onPressed: () {
//                       Get.to(() => SendStarsView());
//                     },
//                     text: "Send Stars 🤩",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   final String shareLink = 'https://example.com/share_link';
//   void _showShareModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Share this link via',
//                 textAlign: TextAlign.center,
//                 style: h3.copyWith(fontSize: 20),
//               ),
//               sh16,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildShareButton(
//                     image: AppImages.facebook,
//                     color: Colors.blue,
//                     onTap: () => Share.share(
//                       'Check out this post: $shareLink',
//                       subject: 'Post Link',
//                     ),
//                   ),
//                   _buildShareButton(
//                     image: AppImages.messenger,
//                     color: Colors.blueAccent,
//                     onTap: () => Share.share(
//                       'Check out this post: $shareLink',
//                       subject: 'Post Link',
//                     ),
//                   ),
//                   _buildShareButton(
//                     image: AppImages.instagram,
//                     color: Colors.pink,
//                     onTap: () => Share.share(
//                       'Check out this post: $shareLink',
//                       subject: 'Post Link',
//                     ),
//                   ),
//                   _buildShareButton(
//                     image: AppImages.whatsApp,
//                     color: Colors.green,
//                     onTap: () => Share.share(
//                       'Check out this post: $shareLink',
//                       subject: 'Post Link',
//                     ),
//                   ),
//                   _buildShareButton(
//                     image: AppImages.telegram,
//                     color: Colors.lightBlue,
//                     onTap: () => Share.share(
//                       'Check out this post: $shareLink',
//                       subject: 'Post Link',
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Or Copy Link',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.grey[200],
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       shareLink,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Spacer(),
//                     CustomButton(
//                       width: 80,
//                       height: 35,
//                       onPressed: () {
//                         Clipboard.setData(ClipboardData(text: shareLink));
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Link copied to clipboard')),
//                         );
//                       },
//                       text: 'Copy',
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildShareButton({required String image, required Color color, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: CircleAvatar(
//         backgroundColor: color.withOpacity(0.2),
//         radius: 24,
//         child: Image.asset(image,scale: 4,),
//       ),
//     );
//   }
// }



import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tails_date/app/modules/home/views/report_view.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../../../common/app_text_style/styles.dart';
import '../../../../../../common/widgets/custom_popup_menu_button.dart';
import '../../../../profile/views/buy_star_view.dart';
import '../../../../profile/views/send_stars_view.dart';

class UserPostCard extends StatelessWidget {
  final String userName;
  final String location;
  final String profileImage;
  final List<String> images;
  final String timeAgo;
  final String description;
  final int likeCount;
  final VoidCallback? onAddFriend;
  final Widget? popupMenuButton;
  final bool showAddFriendButton;

  const UserPostCard({
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
    this.showAddFriendButton = true, // Default to showing the button
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
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
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Buttons in Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showAddFriendButton)
                      CustomButton(
                        width: 90,
                        text: 'Add friend',
                        onPressed: onAddFriend!,
                        height: 30,
                        backgroundColor: AppColors.black,
                        borderRadius: 8,
                        textStyle: h6.copyWith(color: AppColors.white),
                      ),
                    const SizedBox(width: 8),
                    popupMenuButton ?? CustomPopupMenuButton(
                      items: [
                        PopupMenuItemData(
                          value: 'Report Content',
                          label: 'Report Content',
                          onSelected: () {
                            Get.to(() => ReportView(), transition: Transition.downToUp);
                          },
                        ),
                        PopupMenuItemData(isDivider: true),
                        PopupMenuItemData(
                          value: 'Not Interested',
                          label: 'Not Interested',
                          onSelected: () {
                            log('Not Interested selected');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
                  height: 400,
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
                padding: EdgeInsets.all(2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: images.length <= 3 ? images.length : 2, // 1 row for 1-3 images, 2 rows for 4 images
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
                _buildIcon(AppImages.heart, likeCount),
                _buildIcon(AppImages.star, null, onTap: () => showStarBuyDialog(context)),
                _buildIcon(AppImages.share, null, onTap: () => _showShareModal(context)),
                _buildIcon(AppImages.bookmark, null),
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
          const SizedBox(width: 16),
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
                  Text('Support what you love! 🌟', style: h3, textAlign: TextAlign.center),
                  Image.asset(AppImages.starImage, scale: 4),
                  const SizedBox(height: 8),
                  CustomButton(
                    onPressed: () => Get.to(() => BuyStarView()),
                    text: "Buy Star 🌟",
                    backgroundColor: AppColors.white,
                    textStyle: h3.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text('OR', style: h3),
                  const SizedBox(height: 8),
                  CustomButton(
                    onPressed: () => Get.to(() => SendStarsView()),
                    text: "Send Stars 🤩",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final String shareLink = 'https://example.com/share_link';
  void _showShareModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Share this link via',
                textAlign: TextAlign.center,
                style: h3.copyWith(fontSize: 20),
              ),
              sh16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShareButton(
                    image: AppImages.facebook,
                    color: Colors.blue,
                    onTap: () => Share.share(
                      'Check out this post: $shareLink',
                      subject: 'Post Link',
                    ),
                  ),
                  _buildShareButton(
                    image: AppImages.messenger,
                    color: Colors.blueAccent,
                    onTap: () => Share.share(
                      'Check out this post: $shareLink',
                      subject: 'Post Link',
                    ),
                  ),
                  _buildShareButton(
                    image: AppImages.instagram,
                    color: Colors.pink,
                    onTap: () => Share.share(
                      'Check out this post: $shareLink',
                      subject: 'Post Link',
                    ),
                  ),
                  _buildShareButton(
                    image: AppImages.whatsApp,
                    color: Colors.green,
                    onTap: () => Share.share(
                      'Check out this post: $shareLink',
                      subject: 'Post Link',
                    ),
                  ),
                  _buildShareButton(
                    image: AppImages.telegram,
                    color: Colors.lightBlue,
                    onTap: () => Share.share(
                      'Check out this post: $shareLink',
                      subject: 'Post Link',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Or Copy Link',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Text(
                      shareLink,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    CustomButton(
                      width: 80,
                      height: 35,
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: shareLink));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Link copied to clipboard')),
                        );
                      },
                      text: 'Copy',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareButton({required String image, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        radius: 24,
        child: Image.asset(image,scale: 4,),
      ),
    );
  }
}
