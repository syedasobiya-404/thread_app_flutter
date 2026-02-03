import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/services/navigation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavigationService navigationService = Get.put(NavigationService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: navigationService.pages[navigationService.currentPage.value],
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationService.currentPage.value,
          onDestinationSelected: (value) {
            navigationService.updateIndex(value);
          },
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: ""),
            NavigationDestination(icon: Icon(Icons.search), label: ""),
            NavigationDestination(icon: Icon(Icons.add), label: ""),
            NavigationDestination(icon: Icon(Icons.favorite), label: ""),
            NavigationDestination(icon: Icon(Icons.person), label: ""),
          ],
        ),
      ),
    );
  }
}
