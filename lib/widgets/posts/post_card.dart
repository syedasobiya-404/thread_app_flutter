import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/threads_controller.dart';
import 'package:thread_app/models/post.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/utils/helpers.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  ThreadsController threadsController = Get.find<ThreadsController>();

  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: widget.post.users!.metaData?.image != null
                    ? NetworkImage(
                        "https://qqdxcqiakaxrshnwbvxt.supabase.co/storage/v1/object/public/${widget.post.users!.metaData!.image}")
                    : AssetImage("./assets/images/avatar.png"),
              ),
            ),
            SizedBox(
              width: context.width * 0.8,
              child: Column(
                children: [
                  ListTile(
                    isThreeLine: true,
                    title: Text(
                      widget.post.users!.metaData!.name!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: GestureDetector(
                      onTap: () {
                        Get.toNamed("/threads-preview");
                      },
                      child: Text(
                        widget.post.content!,
                      ),
                    ),
                    trailing: Text(
                      Helpers.formatDateTime(
                        widget.post.createdAt!,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  widget.post.image != null
                      ? GestureDetector(
                          onTap: () {
                            Get.toNamed("/thread-image-preview");
                          },
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: context.height * 0.40,
                              maxWidth: context.width * 100,
                              minWidth: context.width * 100,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              child: Image.network(
                                "https://qqdxcqiakaxrshnwbvxt.supabase.co/storage/v1/object/public/${widget.post.image}",
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Helpers.showCustomSnackBar(
                            "Success",
                            isLiked
                                ? "Liked Removed Successfully"
                                : "Liked Successfully",
                          );
                          isLiked = !isLiked;
                          setState(() {});
                        },
                        icon: Icon(
                          color: isLiked == true ? Colors.red : null,
                          Icons.favorite,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed("/add-reply", arguments: widget.post);
                        },
                        icon: Icon(
                          Icons.chat_bubble,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send_outlined,
                        ),
                      ),
                      widget.post.userId ==
                              SupabaseService.currentUser.value!.id
                          ? IconButton(
                              onPressed: () {
                                Helpers.showConfirmationDialog(
                                  "Are You Sure",
                                  "This Action Will Delete This Post",
                                  () {
                                    threadsController.deleteThread(
                                      widget.post.postId!,
                                    );
                                    Get.back();
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("${widget.post.replyCount} Replies"),
                      SizedBox(
                        width: 12,
                      ),
                      Text("${widget.post.likeCount} Likes"),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey[700],
        )
      ],
    );
  }
}
