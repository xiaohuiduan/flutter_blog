import 'package:flutter_blog/model/data_model/wanandroid_article_model_entity.dart';
import 'package:flutter_blog/model/data_model/wx_article_person_entity.dart';
import 'package:flutter_blog/model/data_model/wx_article_list_entity.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/user_info_entity.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/user_detail_info_entity.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/cnblog_site_home_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticleModel") {
      return ArticleModel.fromJson(json) as T;
    } else if (T.toString() == "WxArticlePersonEntity") {
      return WxArticlePersonEntity.fromJson(json) as T;
    } else if (T.toString() == "WxArticleListEntity") {
      return WxArticleListEntity.fromJson(json) as T;
    } else if (T.toString() == "UserInfoEntity") {
      return UserInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "UserDetailInfoEntity") {
      return UserDetailInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "CnblogSiteHomeEntity") {
      return CnblogSiteHomeEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
