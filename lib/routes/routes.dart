import 'package:get/get.dart';
import 'package:thread_app/views/auth/login_screen.dart';
import 'package:thread_app/views/auth/register_screen.dart';
import 'package:thread_app/views/home/home_screen.dart';
import 'package:thread_app/views/profile/update_profile_screen.dart';
import 'package:thread_app/views/settings/settings_screen.dart';
import 'package:thread_app/views/thread/add_reply_screen.dart';
import 'package:thread_app/views/thread/thread_image_preview.dart';
import 'package:thread_app/views/thread/threads_preview.dart';

final List<GetPage> pages = [
  GetPage(
    name: "/",
    page: () => HomeScreen(),
  ),
  GetPage(
    name: "/login",
    page: () => LoginScreen(),
  ),
  GetPage(
    name: "/register",
    page: () => RegisterScreen(),
  ),
  GetPage(
    name: "/settings",
    page: () => SettingsScreen(),
  ),
  GetPage(
    name: "/update-profile",
    page: () => UpdateProfileScreen(),
  ),
  GetPage(
    name: "/threads-preview",
    page: () => ThreadsPreview(),
  ),
  GetPage(
    name: "/add-reply",
    page: () => AddReplyScreen(),
  ),
  GetPage(
    name: "/thread-image-preview",
    page: () => ThreadImagePreview(),
  ),
];
