import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/profile_controller.dart';
import 'package:thread_app/services/supabase_service.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    String? description =
        SupabaseService.currentUser.value!.userMetadata?["description"];
    if (description != null) {
      textEditingController.text = description;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              profileController
                  .updateProfile(SupabaseService.currentUser.value!.id);
            },
            child: Text(
              "Update",
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        profileController.profilePicture.value != null
                            ? FileImage(
                                profileController.profilePicture.value!,
                              )
                            : SupabaseService.currentUser.value!
                                        .userMetadata?["image"] !=
                                    null
                                ? NetworkImage(
                                    SupabaseService.currentUser.value!
                                        .userMetadata?["image"],
                                  )
                                : AssetImage(
                                    "./assets/images/avatar.png",
                                  ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    profileController.pickImage();
                  },
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Muhammad Ali",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            TextField(
              controller: textEditingController,
              onChanged: (value) {
                profileController.profileDescription.value = value;
              },
              decoration: InputDecoration(
                hintText: "Your Description",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
