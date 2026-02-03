import 'package:get/get.dart';
import 'package:thread_app/models/Notification.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/utils/helpers.dart';

class NotificationsController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxList<Notification> notifications = RxList<Notification>([]);

  Future<void> fetchNotifications(String userId) async {
    try {
      isLoading.value = true;
      final data = await SupabaseService.client.from('notifications').select('''
    id , notification , user_id , to_user_id , post_id , created_at , users:user_id(email , meta_data)
  ''').eq("to_user_id", userId).order(
            "created_at",
            ascending: false,
          );

      if (data.isNotEmpty) {
        notifications.value = [
          for (var item in data) Notification.fromJson(item)
        ];
      }
      print(data);
    } catch (e) {
      notifications.value = [];
      Helpers.showCustomSnackBar(
        "Error",
        "Some Error Occured",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
