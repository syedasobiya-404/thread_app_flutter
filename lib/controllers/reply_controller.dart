import 'package:get/get.dart';
import 'package:thread_app/models/reply.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/utils/helpers.dart';

class ReplyController extends GetxController {
  // var replyContent = "".obs;
  Rx<String> replyContent = Rx<String>("");
  RxBool isLoading = false.obs;
  RxBool fetchIsLoading = false.obs;
  RxList<Reply> replies = RxList<Reply>([]);

  Future<void> addReply(int postId, String userId, String toUserId) async {
    isLoading.value = true;
    try {
      await SupabaseService.client.from('replies').insert({
        'reply': replyContent.value,
        'user_id': userId,
        "to_user_id": toUserId,
        "post_id": postId,
      });

      await SupabaseService.client.from('notifications').insert({
        'notification': "Replied On Your Post",
        'user_id': userId,
        "to_user_id": toUserId,
        "post_id": postId,
      });

      await SupabaseService.client
          .rpc('comment_increment', params: {'row_id': postId});

      Helpers.showCustomSnackBar(
        "Success",
        "Reply Added Successfully",
      );

      Get.back();
    } catch (e) {
      Helpers.showCustomSnackBar(
        "Error",
        "Some Error Occured While Replying",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchReplies(int postId) async {
    try {
      fetchIsLoading.value = true;
      final data = await SupabaseService.client.from('replies').select('''
id , reply , user_id , to_user_id , post_id , created_at , users:user_id(email , meta_data)
''').eq("post_id", postId);

      if (data.isNotEmpty) {
        replies.value = [for (var item in data) Reply.fromJson(item)];
      }
    } catch (e) {
      Helpers.showCustomSnackBar(
        "Error",
        "Some Error Occured",
      );
    } finally {
      fetchIsLoading.value = false;
    }
  }
}
