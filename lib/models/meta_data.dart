class MetaData {
  String? sub;
  String? name;
  String? email;
  bool? emailVerified;
  bool? phoneVerified;
  String? image;
  String? description;

  MetaData(
      {this.sub,
      this.name,
      this.email,
      this.emailVerified,
      this.phoneVerified,
      this.image,
      this.description});

  MetaData.fromJson(Map<String, dynamic> json) {
    sub = json['sub'];
    name = json['name'];
    email = json['email'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub'] = sub;
    data['name'] = name;
    data['email'] = email;
    data['email_verified'] = emailVerified;
    data['phone_verified'] = phoneVerified;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}
