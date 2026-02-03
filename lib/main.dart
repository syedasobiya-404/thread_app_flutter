import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/routes/routes.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SupabaseService());
  runApp(const ThreadsApp());
}

class ThreadsApp extends StatelessWidget {
  const ThreadsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      title: "Threads",
      getPages: pages,
      initialRoute: "/login",
    );
  }
}
