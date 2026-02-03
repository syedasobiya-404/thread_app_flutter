import 'dart:io';
import 'package:get/get.dart';
import 'package:thread_app/models/post.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/utils/helpers.dart';
import 'package:uuid/uuid.dart';

class ThreadsController extends GetxController {
  Rx<File?> postImage = Rx<File?>(null);
  Rx<String> content = Rx<String>("");
  RxList<PostModel> posts = RxList<PostModel>([]);
  RxBool isLoading = RxBool(false);

  Future<void> pickImage() async {
    File? image = await Helpers.pickImageFromGallery();

    if (image != null) {
      postImage.value = image;
    }
  }

  Future<void> postThread(String userId) async {
    try {
      isLoading.value = true;
      var responce = null;

      if (postImage.value != null) {
        responce = await SupabaseService.client.storage
            .from("threads")
            .upload("$userId/${Uuid().v6()}.jpg", postImage.value!);

        print(responce);
      }

      await SupabaseService.client.from("posts").insert({
        "content": content.value,
        "image": responce,
        "like_count": 0,
        "reply_count": 0,
        "user_id": userId
      });

      content.value = "";
      postImage.value = null;
      Get.back();

      Helpers.showCustomSnackBar("Success", "Post created Successfully");
    } catch (e) {
      print(e);
      print(e);
      Helpers.showCustomSnackBar("Error", "Failed To Upload Thraed");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchThreads() async {
    try {
      isLoading.value = true;
      final data = await SupabaseService.client.from('posts').select('''
    post_id , content , image , like_count , reply_count , user_id , created_at , users:user_id(email , meta_data)
  ''').order(
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

  Future<void> deleteThread(int postId) async {
    try {
      await SupabaseService.client.from('posts').delete().eq('post_id', postId);
      Helpers.showCustomSnackBar(
        "Success",
        "Post Deleted Successfully",
      );
    } catch (e) {
      Helpers.showCustomSnackBar(
        "Error",
        "Some Error Occured",
      );
    }
  }
}
