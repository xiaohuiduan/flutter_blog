import 'dart:convert';

import 'package:flutter/widgets.dart';

class CnblogSiteHomeList {
  List<CnblogSiteHomeEntity> data;

  factory CnblogSiteHomeList(jsonStr) {
    return jsonStr == null
        ? null
        : jsonStr is String
            ? new CnblogSiteHomeList.fromJson(json.decode(jsonStr))
            : new CnblogSiteHomeList.fromJson(jsonStr);
  }

  CnblogSiteHomeList.fromJson(List<dynamic> json) {
    if (json != null) {
      data = new List();
      (json).forEach((v) {
        data.add(CnblogSiteHomeEntity.fromJson(v));
      });
    }
  }
}

class CnblogSiteHomeEntity {
  String description;
  int diggCount;
  String title;
  String author;
  int viewCount;
  int commentCount;
  int id;
  String postDate;
  String blogApp;
  String url;
  String avatar;

  CnblogSiteHomeEntity(
      {this.description,
      this.diggCount,
      this.title,
      this.author,
      this.viewCount,
      this.commentCount,
      this.id,
      this.postDate,
      this.blogApp,
      this.url,
      this.avatar});

  CnblogSiteHomeEntity.fromJson(Map<String, dynamic> json) {
    description = json['Description'];
    diggCount = json['DiggCount'];
    title = json['Title'];
    author = json['Author'];
    viewCount = json['ViewCount'];
    commentCount = json['CommentCount'];
    id = json['Id'];
    postDate = json['PostDate'];
    blogApp = json['BlogApp'];
    url = json['Url'];
    avatar = json['Avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Description'] = this.description;
    data['DiggCount'] = this.diggCount;
    data['Title'] = this.title;
    data['Author'] = this.author;
    data['ViewCount'] = this.viewCount;
    data['CommentCount'] = this.commentCount;
    data['Id'] = this.id;
    data['PostDate'] = this.postDate;
    data['BlogApp'] = this.blogApp;
    data['Url'] = this.url;
    data['Avatar'] = this.avatar;
    return data;
  }
}
