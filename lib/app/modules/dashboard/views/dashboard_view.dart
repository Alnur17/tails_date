import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tails_date/app/modules/chats/views/chats_view.dart';
import 'package:tails_date/app/modules/home/views/home_view.dart';
import 'package:tails_date/app/modules/profile/views/profile_view.dart';
import 'package:tails_date/app/modules/reels/views/reels_view.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../upload_post/views/upload_post_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const ReelsView(),
    ChatsView(),
    const ProfileView(),
  ];

  void _changeTabIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomAppBar(
              padding: EdgeInsets.zero,
              height: 80,
              color: AppColors.black,
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _changeTabIndex(0),
                      child: NavBarItem(
                        selectedIcon: AppImages.homeFilled,
                        unselectedIcon: AppImages.home,
                        label: 'Home'.tr,
                        isSelected: _selectedIndex == 0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(behavior: HitTestBehavior.opaque,
                      onTap: () => _changeTabIndex(1),
                      child: NavBarItem(
                        selectedIcon: AppImages.reelsFilled,
                        unselectedIcon: AppImages.reels,
                        label: 'Reels'.tr,
                        isSelected: _selectedIndex == 1,
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.20),
                  Expanded(
                    child: GestureDetector(behavior: HitTestBehavior.opaque,
                      onTap: () => _changeTabIndex(2),
                      child: NavBarItem(
                        selectedIcon: AppImages.chatFilled,
                        unselectedIcon: AppImages.chat,
                        label: 'Chat'.tr,
                        isSelected: _selectedIndex == 2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(behavior: HitTestBehavior.opaque,
                      onTap: () => _changeTabIndex(3),
                      child: NavBarItem(
                        selectedIcon: AppImages.profileFilled,
                        unselectedIcon: AppImages.profile,
                        label: 'Profile'.tr,
                        isSelected: _selectedIndex == 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 35,
              left: Get.width * 0.42,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                  border: Border(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FloatingActionButton(
                    backgroundColor: AppColors.white,
                    onPressed: () {
                      Get.to(() => UploadPostView());
                    },
                    shape: const CircleBorder(),
                    child: Icon(
                      Icons.add,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String selectedIcon;
  final String unselectedIcon;
  final String label;
  final bool isSelected;

  const NavBarItem({
    super.key,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          isSelected ? selectedIcon : unselectedIcon,
          scale: 4,
        ),
        sh5,
        Center(
          child: Text(
            label,
            style: h6.copyWith(
              color: isSelected ? AppColors.white : Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}