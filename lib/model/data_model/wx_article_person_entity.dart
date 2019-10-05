import 'dart:convert';

class WxArticlePersonEntity {
  WxArticlePersonData data;
  int errorCode;
  String errorMsg;

  WxArticlePersonEntity.fromParams({this.data, this.errorCode, this.errorMsg});

  factory WxArticlePersonEntity(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new WxArticlePersonEntity.fromJson(json.decode(jsonStr))
          : new WxArticlePersonEntity.fromJson(jsonStr);

  WxArticlePersonEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new WxArticlePersonData.fromJson(json['data'])
        : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class WxArticlePersonData {
  bool over;
  int pageCount;
  int total;
  int curPage;
  int offset;
  int size;
  List<WxArticlePersonDataData> datas;

  WxArticlePersonData(
      {this.over,
      this.pageCount,
      this.total,
      this.curPage,
      this.offset,
      this.size,
      this.datas});

  WxArticlePersonData.fromJson(Map<String, dynamic> json) {
    over = json['over'];
    pageCount = json['pageCount'];
    total = json['total'];
    curPage = json['curPage'];
    offset = json['offset'];
    size = json['size'];
    if (json['datas'] != null) {
      datas = new List<WxArticlePersonDataData>();
      (json['datas'] as List).forEach((v) {
        datas.add(new WxArticlePersonDataData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over'] = this.over;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    data['curPage'] = this.curPage;
    data['offset'] = this.offset;
    data['size'] = this.size;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WxArticlePersonDataData {
  dynamic shareDate;
  String projectLink;
  String prefix;
  String origin;
  String link;
  String title;
  int type;
  String apkLink;
  String envelopePic;
  int audit;
  int chapterId;
  int id;
  int courseId;
  String superChapterName;
  int publishTime;
  String niceShareDate;
  int visible;
  String niceDate;
  String author;
  int zan;
  String chapterName;
  int userId;
  List<WxArticlePersonDataDatasTag> tags;
  int superChapterId;
  bool fresh;
  bool collect;
  String shareUser;
  String desc;

  WxArticlePersonDataData(
      {this.shareDate,
      this.projectLink,
      this.prefix,
      this.origin,
      this.link,
      this.title,
      this.type,
      this.apkLink,
      this.envelopePic,
      this.audit,
      this.chapterId,
      this.id,
      this.courseId,
      this.superChapterName,
      this.publishTime,
      this.niceShareDate,
      this.visible,
      this.niceDate,
      this.author,
      this.zan,
      this.chapterName,
      this.userId,
      this.tags,
      this.superChapterId,
      this.fresh,
      this.collect,
      this.shareUser,
      this.desc});

  WxArticlePersonDataData.fromJson(Map<String, dynamic> json) {
    shareDate = json['shareDate'];
    projectLink = json['projectLink'];
    prefix = json['prefix'];
    origin = json['origin'];
    link = json['link'];
    title = json['title'];
    type = json['type'];
    apkLink = json['apkLink'];
    envelopePic = json['envelopePic'];
    audit = json['audit'];
    chapterId = json['chapterId'];
    id = json['id'];
    courseId = json['courseId'];
    superChapterName = json['superChapterName'];
    publishTime = json['publishTime'];
    niceShareDate = json['niceShareDate'];
    visible = json['visible'];
    niceDate = json['niceDate'];
    author = json['author'];
    zan = json['zan'];
    chapterName = json['chapterName'];
    userId = json['userId'];
    if (json['tags'] != null) {
      tags = new List<WxArticlePersonDataDatasTag>();
      (json['tags'] as List).forEach((v) {
        tags.add(new WxArticlePersonDataDatasTag.fromJson(v));
      });
    }
    superChapterId = json['superChapterId'];
    fresh = json['fresh'];
    collect = json['collect'];
    shareUser = json['shareUser'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shareDate'] = this.shareDate;
    data['projectLink'] = this.projectLink;
    data['prefix'] = this.prefix;
    data['origin'] = this.origin;
    data['link'] = this.link;
    data['title'] = this.title;
    data['type'] = this.type;
    data['apkLink'] = this.apkLink;
    data['envelopePic'] = this.envelopePic;
    data['audit'] = this.audit;
    data['chapterId'] = this.chapterId;
    data['id'] = this.id;
    data['courseId'] = this.courseId;
    data['superChapterName'] = this.superChapterName;
    data['publishTime'] = this.publishTime;
    data['niceShareDate'] = this.niceShareDate;
    data['visible'] = this.visible;
    data['niceDate'] = this.niceDate;
    data['author'] = this.author;
    data['zan'] = this.zan;
    data['chapterName'] = this.chapterName;
    data['userId'] = this.userId;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['superChapterId'] = this.superChapterId;
    data['fresh'] = this.fresh;
    data['collect'] = this.collect;
    data['shareUser'] = this.shareUser;
    data['desc'] = this.desc;
    return data;
  }
}

class WxArticlePersonDataDatasTag {
  String name;
  String url;

  WxArticlePersonDataDatasTag({this.name, this.url});

  WxArticlePersonDataDatasTag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
