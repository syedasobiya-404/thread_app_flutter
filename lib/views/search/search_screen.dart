import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/search_user_controller.dart';
import 'package:thread_app/models/user.dart';
import 'package:thread_app/services/navigation_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NavigationService navigationService = Get.find<NavigationService>();

  SearchUserController searchController = Get.put(SearchUserController());
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
        title: Text("Search"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Obx(
          () => Column(
            children: [
              TextField(
                onChanged: (value) {
                  searchController.searchUserData(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(
                    0Xff242424,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  hintText: "Search User...",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                    10,
                  )),
                ),
              ),
              searchController.users.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                      itemCount: searchController.users.length,
                      itemBuilder: (context, index) {
                        Users user = searchController.users[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: user.metaData?.image != null
                                ? NetworkImage(
                                    "https://qqdxcqiakaxrshnwbvxt.supabase.co/storage/v1/object/public/${user.metaData!.image}",
                                  )
                                : AssetImage("./assets/images/avatar.png"),
                          ),
                          title: Text(user.metaData!.name!),
                          subtitle: Text(
                            user.metaData!.description ??
                                "Hey I Am Using Threads!",
                          ),
                        );
                      },
                    ))
                  : Center(
                      child: Text("No User Found "),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
