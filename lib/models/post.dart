import 'package:thread_app/models/user.dart';

class PostModel {
  int? postId;
  String? content;
  String? image;
  int? likeCount;
  int? replyCount;
  String? userId;
  String? createdAt;
  Users? users;

  PostModel(
      {this.postId,
      this.content,
      this.image,
      this.likeCount,
      this.replyCount,
      this.userId,
      this.createdAt,
      this.users});

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    content = json['content'];
    image = json['image'];
    likeCount = json['like_count'];
    replyCount = json['reply_count'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['content'] = content;
    data['image'] = image;
    data['like_count'] = likeCount;
    data['reply_count'] = replyCount;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}
