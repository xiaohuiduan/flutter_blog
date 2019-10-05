import 'package:flutter_blog/model/data_model/wanandroid_article_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticleModel") {
      return ArticleModel(json) as T;
    } else {
      return null;
    }
  }
}
