import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> _screens = [
    const HomeView(),
    Container(color: Colors.red,),
    Container(color: Colors.green,),
    Container(color: Colors.blue,),
  ];


  Widget get currentScreen => _screens[selectedIndex.value];


  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}