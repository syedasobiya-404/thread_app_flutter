import 'package:get/get.dart';
import 'package:thread_app/services/supabase_service.dart';

class SettingsController extends GetxController {
  Future<void> logout() async {
    await SupabaseService.client.auth.signOut();
    Get.offAllNamed("/login");
  }
}
