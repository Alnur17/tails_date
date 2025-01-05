import 'package:flutter/material.dart';
import 'package:tails_date/app/modules/chats/views/chats_view.dart';
import 'package:tails_date/app/modules/home/views/home_view.dart';
import 'package:tails_date/app/modules/notifications/views/notifications_view.dart';
import 'package:tails_date/app/modules/reels/views/reels_view.dart';
import 'package:tails_date/common/app_images/app_images.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';

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
    const NotificationsView(),
  ];

  void _changeTabIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomAppBar(
            padding: EdgeInsets.zero,
            height: 80,
            color: AppColors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _changeTabIndex(0),
                  child: NavBarItem(
                    selectedIcon: AppImages.homeFilled,
                    unselectedIcon: AppImages.home,
                    label: "Home",
                    isSelected: _selectedIndex == 0,
                  ),
                ),
                GestureDetector(
                  onTap: () => _changeTabIndex(1),
                  child: NavBarItem(
                    selectedIcon: AppImages.reelsFilled,
                    unselectedIcon: AppImages.reels,
                    label: "Reels",
                    isSelected: _selectedIndex == 1,
                  ),
                ),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () => _changeTabIndex(2),
                  child: NavBarItem(
                    selectedIcon: AppImages.chatFilled,
                    unselectedIcon: AppImages.chat,
                    label: "Chat",
                    isSelected: _selectedIndex == 2,
                  ),
                ),
                GestureDetector(
                  onTap: () => _changeTabIndex(3),
                  child: NavBarItem(
                    selectedIcon: AppImages.notificationFilled,
                    unselectedIcon: AppImages.notification,
                    label: "Notification",
                    isSelected: _selectedIndex == 3,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            left: MediaQuery.of(context).size.width * 0.4,
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
                  onPressed: () {},
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.add,
                    size: MediaQuery.of(context).size.width * 0.09,
                  ),
                ),
              ),
            ),
          ),
        ],
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
        const SizedBox(height: 4),
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
