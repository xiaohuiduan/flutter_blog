// 玩Android的API
class WanAndroidApi {
  ///获得首页数据
  ///https://www.wanandroid.com/article/list/0/json
  ///方法：GET
  ///参数：页码，拼接在连接中，从0开始。
  static const String HOME_ARTICLE_LIST =
      "https://www.wanandroid.com/article/list/";

  ///获得公众号
  static const String WX_ARTICLE_LIST =
      "https://wanandroid.com/wxarticle/chapters/json";

  /// 获得微信某个人的数据
  static const String WX_ARTICLE_PERSON =
      "https://wanandroid.com/wxarticle/list/";
}
