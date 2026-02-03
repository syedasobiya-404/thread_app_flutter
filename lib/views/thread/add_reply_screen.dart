import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/reply_controller.dart';
import 'package:thread_app/models/post.dart';
import 'package:thread_app/models/reply.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/widgets/posts/reply_card.dart';

class AddReplyScreen extends StatefulWidget {
  const AddReplyScreen({super.key});

  @override
  State<AddReplyScreen> createState() => _AddReplyScreenState();
}

class _AddReplyScreenState extends State<AddReplyScreen> {
  ReplyController replyController = Get.put(ReplyController());

  PostModel post = Get.arguments;

  @override
  void initState() {
    PostModel post = Get.arguments;
    replyController.fetchReplies(
      post.postId!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Thread Preview",
          ),
          centerTitle: true,
          actions: [
            Obx(
              () => TextButton(
                onPressed: () async {
                  if (replyController.isLoading.value == false) {
                    if (replyController.replyContent.isNotEmpty) {
                      await replyController.addReply(
                        post.postId!,
                        SupabaseService.currentUser.value!.id,
                        post.userId!,
                      );
                    }
                  }
                },
                child: Text(
                  replyController.isLoading.value == true ? "Repling" : "Reply",
                  style: TextStyle(
                    color: replyController.replyContent.value.isEmpty
                        ? Colors.grey
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  onChanged: (value) {
                    replyController.replyContent.value = value;
                  },
                  autofocus: true,
                  maxLength: 500,
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type a reply.",
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Replies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                child: Obx(
                  () => replyController.fetchIsLoading.value == true
                      ? Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : SingleChildScrollView(
                          child: SizedBox(
                          width: double.infinity,
                          child: replyController.replies.isNotEmpty
                              ? ListView.builder(
                                  itemCount: replyController.replies.length,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    Reply reply =
                                        replyController.replies[index];
                                    return ReplyCard(reply: reply);
                                  },
                                )
                              : Center(
                                  child: Text("No Replies Found"),
                                ),
                        )),
                ),
              )
            ],
          ),
        ));
  }
}
