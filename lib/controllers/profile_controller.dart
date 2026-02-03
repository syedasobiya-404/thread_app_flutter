import 'dart:io';
import 'package:thread_app/models/post.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thread_app/models/reply.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/utils/helpers.dart';

class ProfileController extends GetxController {
  Rx<File?> profilePicture = Rx<File?>(null);
  Rx<String> profileDescription = Rx<String>("");
  RxList<PostModel> posts = RxList<PostModel>([]);
  RxBool isLoading = RxBool(false);
  RxBool fetchIsLoading = false.obs;
  RxList<Reply> replies = RxList<Reply>([]);

  Future<void> pickImage() async {
    File? image = await Helpers.pickImageFromGallery();
    if (image != null) {
      profilePicture.value = image;
    }
  }

  Future<void> updateProfile(String userId) async {
    try {
      String fullPath = "";
      if (profilePicture.value != null) {
        fullPath = await SupabaseService.client.storage
            .from('threads')
            .upload('$userId/profile.jpg', profilePicture.value!,
                fileOptions: FileOptions(
                  upsert: true,
                ));
      }

      final UserResponse res = await SupabaseService.client.auth.updateUser(
        UserAttributes(
            data: {"image": fullPath, "description": profileDescription.value}),
      );
      Helpers.showCustomSnackBar("Success", "Profile Updated Successfully");
    } catch (e) {
      print(e);
      Helpers.showCustomSnackBar("Error", "Some Error Occured");
    }
  }

  Future<void> fetchThreads(String userId) async {
    try {
      isLoading.value = true;
      final data = await SupabaseService.client.from('posts').select('''
    post_id , content , image , like_count , reply_count , user_id , created_at , users:user_id(email , meta_data)
  ''').eq("user_id", userId).order(
            "created_at",
            ascending: false,
          );

      if (data.isNotEmpty) {
        posts.value = [for (var item in data) PostModel.fromJson(item)];
      }
    } catch (e) {
      posts.value = [];
      Helpers.showCustomSnackBar(
        "Error",
        "Some Error Occured",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchReplies(String toUserId) async {
    try {
      fetchIsLoading.value = true;
      final data = await SupabaseService.client.from('replies').select('''
id , reply , user_id , to_user_id , post_id , created_at , users:user_id(email , meta_data)
''').eq("to_user_id", toUserId);

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
