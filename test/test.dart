import 'dart:core' as prefix0;
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/user_info_entity.dart';
import 'package:flutter_blog/net/cnblog_service.dart';
import 'package:flutter_blog/net/dio_manager.dart';

main() {
  String token =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6IjlFMjcyMkFGM0IzRTFDNzU5RTI3NEFBRDI5NDFBNzg1MDlCMDc2RDAiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJuaWNpcnpzLUhIV2VKMHF0S1VHbmhRbXdkdEEifQ";
  getUserMsg(token);
}

getUserMsg(token) {
//  print(token);
  DioManager.singleton
      .getDio()
      .get(CnblogApiOption.GET_USER_MSG_URL,
          options: Options(headers: {"Authorization": token}))
      .then((response) {
    prefix0.print(response.data);
//    print(UserInfoEntity(response.data).toString());
  });
}
