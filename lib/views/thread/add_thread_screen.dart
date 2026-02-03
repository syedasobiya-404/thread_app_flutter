import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/threads_controller.dart';
import 'package:thread_app/services/navigation_service.dart';
import 'package:thread_app/services/supabase_service.dart';

class AddThreadScreen extends StatefulWidget {
  const AddThreadScreen({super.key});

  @override
  State<AddThreadScreen> createState() => _AddThreadScreenState();
}

class _AddThreadScreenState extends State<AddThreadScreen> {
  NavigationService navigationService = Get.find<NavigationService>();
  ThreadsController threadsController = Get.put(ThreadsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigationService.currentPage.value =
                navigationService.previousPage.value;
          },
          icon: Icon(
            Icons.close,
          ),
        ),
        title: Text("Add Threads"),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () async {
                if (threadsController.isLoading.value == false) {
                  if (threadsController.content.value.isNotEmpty) {
                    await threadsController.postThread(
                      SupabaseService.currentUser.value!.id,
                    );
                    navigationService.updateIndex(0);
                  }
                }
              },
              child: Text(
                threadsController.isLoading.value == true ? "Posting" : "Post",
                style: TextStyle(
                  color: threadsController.content.value.isEmpty
                      ? Colors.grey
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleAvatar(
                backgroundImage: SupabaseService
                            .currentUser.value!.userMetadata?["image"] !=
                        null
                    ? NetworkImage(
                        "https://qqdxcqiakaxrshnwbvxt.supabase.co/storage/v1/object/public/${SupabaseService.currentUser.value!.userMetadata!["image"]}")
                    : AssetImage("./assets/images/avatar.png"),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SupabaseService.currentUser.value!.userMetadata!["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      threadsController.content.value = value;
                    },
                    autofocus: true,
                    maxLength: 1000,
                    maxLines: 10,
                    minLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type a thread",
                      border: InputBorder.none,
                    ),
                  ),
                  Obx(
                    () => Column(
                      children: [
                        threadsController.postImage.value != null
                            ? Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    child: Image.file(
                                      threadsController.postImage.value!,
                                    ),
                                  ),
                                  Positioned(
                                    // top: 10,
                                    // right: 10,
                                    child: IconButton(
                                      onPressed: () {
                                        threadsController.postImage.value =
                                            null;
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : IconButton(
                                onPressed: () {
                                  threadsController.pickImage();
                                },
                                icon: Icon(
                                  Icons.attach_file,
                                ),
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
