import 'package:flutter/material.dart';
import 'package:tails_date/common/app_color/app_colors.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import 'package:tails_date/common/size_box/custom_sizebox.dart';
import 'package:tails_date/common/widgets/custom_button.dart';

import '../../../../../../common/app_text_style/styles.dart';

class UserPostCard extends StatelessWidget {
  final String userName;
  final String location;
  final String profileImage;
  final List<String> images;
  final String timeAgo;
  final String description;
  final int likeCount;
  final VoidCallback onAddFriend;
  final VoidCallback onMoreOptions;

  const UserPostCard({
    super.key,
    required this.userName,
    required this.location,
    required this.profileImage,
    required this.images,
    required this.timeAgo,
    required this.description,
    required this.likeCount,
    required this.onAddFriend,
    required this.onMoreOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          AppImages.location,
                          scale: 4,
                        ),
                        sw5,
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                CustomButton(
                  text: 'Add friend',
                  onPressed: onAddFriend,
                  height: 30,
                  backgroundColor: AppColors.black,
                  borderRadius: 8,
                  textStyle: h6.copyWith(color: AppColors.white),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onMoreOptions,
                  child: Image.asset(
                    AppImages.threeDot,
                    scale: 4,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              description,
              style: h6,
            ),
          ),
          // Image Section
          if (images.length == 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  images[0],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 images per row
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
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
                Text(
                  timeAgo,
                  style: h6,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    AppImages.heart,
                    scale: 4,
                  ),
                ),
                sw5,
                Text(
                  '$likeCount',
                  style: h6,
                ),
                sw8,
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    AppImages.star,
                    scale: 4,
                  ),
                ),
                sw8,
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    AppImages.share,
                    scale: 4,
                  ),
                ),
                sw8,
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    AppImages.bookmark,
                    scale: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}