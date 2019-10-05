import 'dart:core';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/cnblog_site_home_entity.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/user_detail_info_entity.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/user_info_entity.dart';
import 'dio_manager.dart';

class CnblogApiOption {
  static final CLIENT_ID = "60d7c274-2fc9-4355-a51e-914751027179";
  static final CLIENT_SECRET =
      "bai1tbPVOl5b8JRliYTEXQPqwpkan3C2m3Fn3gO6m09bci6m4zkkpk2YsBc_f2ETaRZtw_07t53hEK8t";
  static final GET_CODE_URL = "https://oauth.cnblogs.com/connect/authorize";
  static final GET_TOKEN_URL = "https://oauth.cnblogs.com/connect/token";

  // 获取博客登录信息
  static final GET_USER_MSG_URL = "https://api.cnblogs.com/api/users";

  // 获得我的博客的信息
  static final GET_USER_BLOG_URL = "https://api.cnblogs.com/api/blogs/";

  static final MY_BLOG_URL = "https://www.cnblogs.com/";

  ///  client_id	string	是	申请的client_id	your client_id
  ///  scope	string	是	默认	openid profile CnBlogsApi
  ///  response_type	string	是	默认	code id_token
  ///  redirect_uri	string	是	默认回调地址(可以联系管理员修改)	https://oauth.cnblogs.com/auth/callback
  ///  state	string	是	可以指定任意值(必填)	cnblogs.com
  /// nonce	string	是	随机字符串（自己创建）	cnblogs.com
  static final FormData GET_CODE = FormData.fromMap({
    "client_id": CLIENT_ID,
    "scope": "openid profile CnBlogsApi",
    "response_type": "id_token",
    "redirect_uri": "https://oauth.cnblogs.com/auth/callback",
    "state": "cnblogs.com",
    "nonce": "cnblogs.com",
  });

  static final String GET_CODE_URL_WITH_DATA = GET_CODE_URL +
      "?"
          "client_id=$CLIENT_ID"
          "&scope=openid profile CnBlogsApi"
          "&response_type=code id_token"
          "&redirect_uri=https://oauth.cnblogs.com/auth/callback"
          "&state=cnblogs.com"
          "&nonce=cnblogs.com";

  static final ContentType TOKEN_HEADER =
      ContentType.parse("application/x-www-form-urlencoded");

  ///  client_id	string	是	授权ID	client_id
  ///  client_secret	string	是	密钥	client_secret
  ///  grant_type	string	是	授权模式	authorization_code
  ///  code	string	是	授权码	code
  ///  redirect_uri	string	是	回调地址(默认)	https://oauth.cnblos.com/auth/callback

}

class CnblogNetService {
  RegExp mobile = new RegExp(r"(?<=access_token:).*?(?=,)");

  getToken(String code, Function function) {
    FormData getTokenData = FormData.fromMap({
      "client_id": CnblogApiOption.CLIENT_ID,
      "client_secret": CnblogApiOption.CLIENT_SECRET,
      "grant_type": "authorization_code",
      "redirect_uri": "https://oauth.cnblogs.com/auth/callback",
      "code": code.replaceAll("\"", "")
    });
    DioManager.singleton
        .getDio()
        .post(CnblogApiOption.GET_TOKEN_URL,
            data: getTokenData,
            options: Options(
              contentType: "application/x-www-form-urlencoded",
            ))
        .then((response) {
      String token = mobile.stringMatch(response.data.toString());
      return function(token);
    });
  }

  /// pageIndex 目录页 pageSize 页面文章数量，博客园的首页信息，
  getHomeSite(int pageIndex, int pageSize, String token, Function function) {
    DioManager.singleton
        .getDio()
        .get(
            "https://api.cnblogs.com/api/blogposts/@sitehome?pageIndex=$pageIndex&pageSize=$pageSize",
            options: Options(headers: {"Authorization": "bearer $token"}))
        .then((response) {
      if (response.statusCode == 200) {
        function(CnblogSiteHomeList(response.data));
      } else {
        function(null);
      }
    });
  }

  getUserMsg(token, Function function) {
    DioManager.singleton
        .getDio()
        .get(CnblogApiOption.GET_USER_MSG_URL,
            options: Options(headers: {"Authorization": "bearer $token"}))
        .then((response) {
      if (response.statusCode == 200) {
        function(UserInfoEntity(response.data));
      } else {
        function(null);
      }
    });
  }

  // 获得用户的详细信息
  getUserDetailInfo(blogAppName, token, Function function) {
    DioManager.singleton
        .getDio()
        .get(CnblogApiOption.GET_USER_BLOG_URL + blogAppName,
            options: Options(headers: {"Authorization": "bearer $token"}))
        .then((response) {
      if (response.statusCode == 200) {
        function(UserDetailInfoEntity(response.data));
      } else {
        function(null);
      }
    });
  }
}
