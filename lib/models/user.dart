import 'package:thread_app/models/meta_data.dart';

class Users {
  String? id;
  String? email;
  MetaData? metaData;

  Users({this.id, this.email, this.metaData});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    metaData =
        json['meta_data'] != null ? MetaData.fromJson(json['meta_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    if (metaData != null) {
      data['meta_data'] = metaData!.toJson();
    }
    return data;
  }
}
