import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/user_detail_info_entity.dart';
import 'package:flutter_blog/net/cnblog_service.dart';
import 'package:flutter_blog/static_msg/StaticMsg.dart';
import 'package:flutter_blog/tool/route_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_me.dart';
import 'cnblog_netroute_tool.dart';
import 'cnblog_site_home.dart';

class CnblogInfo extends StatefulWidget {
  @override
  _CnblogInfoState createState() => _CnblogInfoState();
  String blogName;

  CnblogInfo(this.blogName);
}

class _CnblogInfoState extends State<CnblogInfo> {
  CnblogNetService cnblogNetService;
  Future<SharedPreferences> _prefs;
  UserDetailInfoEntity _userDetailInfoEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prefs = SharedPreferences.getInstance();
    cnblogNetService = CnblogNetService();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (_userDetailInfoEntity == null) {
      return Text("获取信息中");
    }
    return ListView.separated(
      itemCount: 3,
      itemBuilder: (context, index) {
        return info(context, index);
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.black26,
        );
      },
    );
  }

  // 显示我的博客等信息
  Widget info(context, int index) {
    switch (index) {
      case (0):
        return InkWell(
            onTap: myCnblogsPage,
            child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.bookmark_border),
                        Text("我的博客",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left),
                      ],
                    ),
                    Text(
                      "写文数量" + _userDetailInfoEntity.postCount.toString(),
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )));
      case (1):
        return InkWell(
            onTap: cnBlogsSiteHome,
            child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.bookmark_border),
                    Text("博客园首页",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left)
                  ],
                )));
      case (2):
        return InkWell(
            onTap: () {
	            Navigator.push(
		            context,
		            new MaterialPageRoute(
			            builder: (context) => new AboutMePage()));
            },
            child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.bookmark_border),
                    Text("关于此项目",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.left)
                  ],
                )));
    }
  }

  //  获得用户的基本信息
  void getUserInfo() {
    _prefs.then((pref) {
      String token = pref.getString(StaticMsg.TOKEN_KEY);
      String blogAppName = pref.getString(StaticMsg.BLOG_NAME_KEY);
      // 获得用户的详细信息
      cnblogNetService.getUserDetailInfo(blogAppName, token, showMyMsg);
    });
  }

  // 将信息进行展示
  showMyMsg(UserDetailInfoEntity userDetailInfoEntity) {
    if (userDetailInfoEntity == null) {}
    setState(() {
      _userDetailInfoEntity = userDetailInfoEntity;
    });
  }

  // 跳转到我的博客园页面
  void myCnblogsPage() {
    CnBlogRouteTool.toWebView(
        context, "我的博客园", CnblogApiOption.MY_BLOG_URL + widget.blogName);
  }

  // 跳转到博客园的首页
  Widget cnBlogsSiteHome() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CnblogSiteHome(StaticMsg.TOKEN)));
  }
}
