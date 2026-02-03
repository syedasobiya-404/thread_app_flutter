import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/threads_controller.dart';
import 'package:thread_app/widgets/posts/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThreadsController threadsController = Get.put(ThreadsController());

  @override
  void initState() {
    threadsController.fetchThreads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          height: 50,
          "./assets/images/logo.png",
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => RefreshIndicator(
          child: threadsController.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: threadsController.posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        post: threadsController.posts[index],
                      );
                    },
                  ),
                ),
          onRefresh: () => threadsController.fetchThreads(),
        ),
      ),
    );
  }
}
