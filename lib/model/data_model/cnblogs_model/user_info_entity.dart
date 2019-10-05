import 'dart:convert';

class UserInfoEntity {
  int spaceUserId;
  String userId;
  int blogId;
  String displayName;
  String face;
  String seniority;
  String blogApp;
  String avatar;

  UserInfoEntity.fromParams(
      {this.spaceUserId,
      this.userId,
      this.blogId,
      this.displayName,
      this.face,
      this.seniority,
      this.blogApp,
      this.avatar});

  factory UserInfoEntity(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new UserInfoEntity.fromJson(json.decode(jsonStr))
          : new UserInfoEntity.fromJson(jsonStr);

  UserInfoEntity.fromJson(Map<String, dynamic> json) {
    spaceUserId = json['SpaceUserId'];
    userId = json['UserId'];
    blogId = json['BlogId'];
    displayName = json['DisplayName'];
    face = json['Face'];
    seniority = json['Seniority'];
    blogApp = json['BlogApp'];
    avatar = json['Avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SpaceUserId'] = this.spaceUserId;
    data['UserId'] = this.userId;
    data['BlogId'] = this.blogId;
    data['DisplayName'] = this.displayName;
    data['Face'] = this.face;
    data['Seniority'] = this.seniority;
    data['BlogApp'] = this.blogApp;
    data['Avatar'] = this.avatar;
    return data;
  }
}
