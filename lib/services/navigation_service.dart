import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/views/home/home_page.dart';
import 'package:thread_app/views/notifications/notifications_screen.dart';
import 'package:thread_app/views/profile/profile_screen.dart';
import 'package:thread_app/views/search/search_screen.dart';
import 'package:thread_app/views/thread/add_thread_screen.dart';

class NavigationService extends GetxService {
  var currentPage = 0.obs;
  var previousPage = 0.obs;

  List<Widget> pages = [
    HomePage(),
    SearchScreen(),
    AddThreadScreen(),
    NotificationsScreen(),
    ProfileScreen()
  ];

  void updateIndex(int index) {
    previousPage.value = currentPage.value;
    currentPage.value = index;
  }
}
