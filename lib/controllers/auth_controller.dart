import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/utils/helpers.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> register(
      String userName, String userEmail, String userPassword) async {
    try {
      isLoading.value = true;
      final AuthResponse res = await SupabaseService.client.auth.signUp(
          password: userPassword, email: userEmail, data: {"name": userName});

      if (res.user != null) {
        Helpers.showCustomSnackBar(
          "Success",
          "Account Register Successfully",
        );
        isLoading.value = false;
        Get.offAllNamed("/login");
      }
    } on AuthException catch (e) {
      Helpers.showCustomSnackBar(
        "Error",
        e.message,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String userEmail, String userPassword) async {
    try {
      isLoading.value = true;
      final AuthResponse res = await SupabaseService.client.auth
          .signInWithPassword(password: userPassword, email: userEmail);
      if (res.user != null) {
        Helpers.showCustomSnackBar(
          "Success",
          "Logged In Successfully",
        );
        isLoading.value = false;
        Get.offAllNamed("/");
      }
    } on AuthException catch (e) {
      Helpers.showCustomSnackBar(
        "Error",
        e.message,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
