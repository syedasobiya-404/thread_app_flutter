import 'package:flutter/material.dart';
import 'package:thread_app/models/reply.dart';
import 'package:thread_app/utils/helpers.dart';


class ReplyCard extends StatelessWidget {
  final Reply reply;
  const ReplyCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: ListTile(
        isThreeLine: true,
        title: Text(
          reply.users!.metaData!.name!,
        ),
        subtitle: Text(reply.reply!),
        trailing: Text(
          Helpers.formatDateTime(
            reply.createdAt!,
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: reply.users!.metaData?.image != null
              ? NetworkImage(
                  "https://qqdxcqiakaxrshnwbvxt.supabase.co/storage/v1/object/public/${reply.users!.metaData!.image!}")
              : AssetImage("./assets/images/avatar.png"),
        ),
      ),
    );
  }
}
