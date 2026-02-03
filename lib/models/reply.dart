import 'package:thread_app/models/user.dart';

class Reply {
  int? id;
  String? reply;
  String? userId;
  String? toUserId;
  int? postId;
  String? createdAt;
  Users? users;

  Reply(
      {this.id,
      this.reply,
      this.userId,
      this.toUserId,
      this.postId,
      this.createdAt,
      this.users});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reply = json['reply'];
    userId = json['user_id'];
    toUserId = json['to_user_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reply'] = this.reply;
    data['user_id'] = this.userId;
    data['to_user_id'] = this.toUserId;
    data['post_id'] = this.postId;
    data['created_at'] = this.createdAt;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

