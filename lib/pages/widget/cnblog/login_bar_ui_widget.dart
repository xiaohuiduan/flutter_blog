import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/user_info_entity.dart';
import 'package:flutter_blog/net/cnblog_service.dart';
import 'package:flutter_blog/static_msg/StaticMsg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cnblog_netroute_tool.dart';

//还未登录的页面
class NotLoginWidget extends StatefulWidget {
  @override
  _NotLoginWidgetState createState() => _NotLoginWidgetState();
}

class _NotLoginWidgetState extends State<NotLoginWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: Login,
        child: Card(
            margin: new EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                      radius: 40.0, backgroundImage: AssetImage("image/1.jpg")),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "登录",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            wordSpacing: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "发现更大的世界",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      ),
                      Text(
                        "点击登录",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 13, color: Colors.yellow),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  // 跳转到登录
  void Login() {
    CnBlogRouteTool.toWebView(
        context, "博客园登录", CnblogApiOption.GET_CODE_URL_WITH_DATA);
  }
}

class HadLoginWidget extends StatefulWidget {
  @override
  _HadLoginWidgetState createState() => _HadLoginWidgetState();
}

//已经登录的操作
class _HadLoginWidgetState extends State<HadLoginWidget> {
  Future<SharedPreferences> _spf;

  String name;
  String face;
  String age;

  String blogName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _spf = SharedPreferences.getInstance();
    CnblogNetService().getUserMsg(StaticMsg.TOKEN, storageMsg);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: layout,
        child: Card(
            margin: new EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                          face == null ? null : NetworkImage(face)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name == null ? "姓名" : name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            wordSpacing: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        age == null ? "园龄" : "园龄$age",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13, color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }

  // 将用户数据保存下来
  storageMsg(UserInfoEntity userInfo) {
    // 假如没有获取到信息
    if (userInfo == null) {
      _spf.then((spf) {
        setState(() {
          spf.remove(StaticMsg.TOKEN_KEY);
          StaticMsg.TOKEN = null;
        });
      });
    }

    String name = userInfo.displayName;
    // 头像
    String face = userInfo.face;
    // 园年龄
    String age = userInfo.seniority;
    // 博客名
    String blogName = userInfo.blogApp;
    setState(() {
      this.name = name;
      this.face = face;
      this.age = age;
      this.blogName = blogName;
    });
    _spf.then((spf) {
      spf.setString(StaticMsg.NAME_KEY, name);
      spf.setString(StaticMsg.FACE_KEY, face);
      spf.setString(StaticMsg.AGE_KEY, age);
      spf.setString(StaticMsg.BLOG_NAME_KEY, blogName);
    });
  }

  // 退出
  void layout() {}
}
