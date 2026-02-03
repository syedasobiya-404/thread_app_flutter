import 'package:get/get.dart';
import 'package:thread_app/models/user.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/utils/helpers.dart';

class SearchUserController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxList<Users> users = RxList<Users>([]);

  Future<void> searchUserData(String name) async {
    try {
      users.value = [];
      isLoading.value = true;
      final data = await SupabaseService.client.from("users").select('''
*
''').like(
        "meta_data->>name",
        name,
      );

      if (data.isNotEmpty) {
        users.value = [for (var item in data) Users.fromJson(item)];
      }
    } catch (e) {
      users.value = [];
      Helpers.showCustomSnackBar(
        "Error",
        "Some Error Occured",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
