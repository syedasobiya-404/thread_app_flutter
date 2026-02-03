import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/settings_controller.dart';
import 'package:thread_app/utils/helpers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Helpers.showConfirmationDialog(
                "Are You Sure?",
                "This action will logout you from the app.",
                () {
                  settingsController.logout();
                },
              );
            },
            title: Text(
              "Logout",
            ),
            leading: Icon(
              Icons.logout,
            ),
            trailing: Icon(
              Icons.arrow_forward,
            ),
          ),
        ],
      ),
    );
  }
}
