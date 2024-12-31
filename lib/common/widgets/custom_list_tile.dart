import 'package:flutter/material.dart';
import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomListTile extends StatelessWidget {
  final String leading;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool useBackgroundImage;

  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.useBackgroundImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.transparent,
        backgroundImage: useBackgroundImage ? AssetImage(leading) : null,
        child: useBackgroundImage
            ? null
            : Image.asset(
                leading,
                scale: 4, // Scale the image
                fit: BoxFit.cover, // Ensure the image fits well
              ),
      ),
      title: Text(
        title,
        style: h4.copyWith(fontSize: 14),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
