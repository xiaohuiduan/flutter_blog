import 'dart:convert';

class UserDetailInfoEntity {
  String subtitle;
  int postCount;
  int pageSize;
  String title;
  int blogId;
  bool enableScript;

  UserDetailInfoEntity.fromParams(
      {this.subtitle,
      this.postCount,
      this.pageSize,
      this.title,
      this.blogId,
      this.enableScript});

  factory UserDetailInfoEntity(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserDetailInfoEntity.fromJson(json.decode(jsonStr))
          : new UserDetailInfoEntity.fromJson(jsonStr);

  UserDetailInfoEntity.fromJson(Map<String, dynamic> json) {
    subtitle = json['subtitle'];
    postCount = json['postCount'];
    pageSize = json['pageSize'];
    title = json['title'];
    blogId = json['blogId'];
    enableScript = json['enableScript'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtitle'] = this.subtitle;
    data['postCount'] = this.postCount;
    data['pageSize'] = this.pageSize;
    data['title'] = this.title;
    data['blogId'] = this.blogId;
    data['enableScript'] = this.enableScript;
    return data;
  }
}
