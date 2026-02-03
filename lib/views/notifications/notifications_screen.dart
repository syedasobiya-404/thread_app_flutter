import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread_app/controllers/notifications_controller.dart';
import 'package:thread_app/services/navigation_service.dart';
import 'package:thread_app/services/supabase_service.dart';
import 'package:thread_app/utils/helpers.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NavigationService navigationService = Get.find<NavigationService>();
  NotificationsController notificationsController =
      Get.put(NotificationsController());

  @override
  void initState() {
    notificationsController
        .fetchNotifications(SupabaseService.currentUser.value!.id);
    super.initState();
  }

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
        title: Text("Notifications"),
      ),
      body: Obx(
        () => Column(
          children: [
            notificationsController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Expanded(
                    child: notificationsController.notifications.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount:
                                  notificationsController.notifications.length,
                              itemBuilder: (context, index) {
                                var notification = notificationsController
                                    .notifications[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    isThreeLine: true,
                                    leading: CircleAvatar(
                                      backgroundImage: notification
                                                  .users!.metaData?.image !=
                                              null
                                          ? NetworkImage(
                                              "https://qqdxcqiakaxrshnwbvxt.supabase.co/storage/v1/object/public/${notification.users!.metaData!.image}")
                                          : AssetImage(
                                              "./assets/images/logo.png",
                                            ),
                                    ),
                                    title: Text(
                                      notification.users!.metaData!.name!,
                                    ),
                                    subtitle: Text(
                                      notification.notification!,
                                    ),
                                    trailing: Text(Helpers.formatDateTime(
                                        notification.createdAt!)),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text("No Notifications Found"),
                          ),
                  )
          ],
        ),
      ),
    );
  }
}
