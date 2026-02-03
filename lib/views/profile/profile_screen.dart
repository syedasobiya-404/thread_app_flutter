import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/profile_controller.dart';
import 'package:thread_app/models/reply.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/widgets/posts/post_card.dart';
import 'package:thread_app/widgets/posts/reply_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.fetchThreads(
      SupabaseService.currentUser.value!.id,
    );
    profileController.fetchReplies(SupabaseService.currentUser.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.language),
        title: Text(
          "Profile Page",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/settings");
            },
            icon: Icon(
              Icons.sort,
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 160,
                  collapsedHeight: 160,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  SupabaseService
                                      .currentUser.value!.userMetadata!["name"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(SupabaseService.currentUser.value!
                                        .userMetadata?["description"] ??
                                    "Hey I Am Using Threads!"),
                              ],
                            ),
                            CircleAvatar(
                              backgroundImage: SupabaseService.currentUser
                                          .value!.userMetadata?["image"] !=
                                      null
                                  ? NetworkImage(
                                      "https://qqdxcqiakaxrshnwbvxt.supabase.co/storage/v1/object/public/${SupabaseService.currentUser.value!.userMetadata!["image"]}")
                                  : AssetImage("./assets/images/avatar.png"),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Get.toNamed("/update-profile");
                                },
                                child: Text(
                                  "Edit Profile",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Share Profile",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: MySliverPersistentHeaderDelegate(
                    tabBar: TabBar(
                      tabs: [
                        Tab(
                          child: Text("Threads"),
                        ),
                        Tab(
                          child: Text("Replies"),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => profileController.posts.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: profileController.posts.length,
                          itemBuilder: (context, index) {
                            var post = profileController.posts[index];
                            return PostCard(
                              post: post,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "You Have Not Done Any Post",
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => SizedBox(
                    child: profileController.replies.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: profileController.replies.length,
                            itemBuilder: (context, index) {
                              Reply reply = profileController.replies[index];
                              return ReplyCard(reply: reply);
                            },
                          )
                        : Center(
                            child: Text(
                              "No Replies Found",
                            ),
                          ),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  MySliverPersistentHeaderDelegate({required TabBar tabBar}) : _tabBar = tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
