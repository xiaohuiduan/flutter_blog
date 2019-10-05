import 'package:flutter_blog/api/WanAndroidApi.dart';
import 'package:flutter_blog/model/data_model/wanandroid_article_model_entity.dart';
import 'package:flutter_blog/model/data_model/wx_article_list_entity.dart';
import 'package:flutter_blog/net/dio_manager.dart';

class WanAndroidService {
  // 获得首页的数据
  getArticleList(Function callback, int _page) async {
    String url = WanAndroidApi.HOME_ARTICLE_LIST + "$_page/json";
    await DioManager.singleton.getDio().get(url).then((response) {
      callback(ArticleModel(response.data));
    });
  }

  getWxArticleList(Function callback) async {
    await DioManager.singleton
        .getDio()
        .get(WanAndroidApi.WX_ARTICLE_LIST)
        .then((response) {
      callback(WxArticleListEntity(response.data));
    });
  }

  getWxArticle(Function callback, int id, int _page) async {
    await DioManager.singleton
        .getDio()
        .get(WanAndroidApi.WX_ARTICLE_PERSON + "$id/$_page/json")
        .then((response) {
      callback(ArticleModel(response.data));
    });
  }
}
