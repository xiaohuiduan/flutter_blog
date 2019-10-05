import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blog/pages/widget/cnblog/cnblog_info.dart';
import 'package:flutter_blog/pages/widget/cnblog/login_bar_ui_widget.dart';
import 'package:flutter_blog/static_msg/StaticMsg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CnblogLoginWeb extends StatefulWidget {
  @override
  _CnblogLoginWebState createState() => _CnblogLoginWebState();
}

class _CnblogLoginWebState extends State<CnblogLoginWeb> {
  Future<SharedPreferences> _prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prefs = SharedPreferences.getInstance();
    _prefs.then((prefs) {
      setState(() {
        StaticMsg.TOKEN = prefs.getString(StaticMsg.TOKEN_KEY);
        StaticMsg.BLOG_NAME = prefs.getString(StaticMsg.BLOG_NAME_KEY);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        StaticMsg.TOKEN == null ? NotLoginWidget() : HadLoginWidget(),
        StaticMsg.BLOG_NAME == null
            ? Text("等待登录")
            : Expanded(child: CnblogInfo(StaticMsg.BLOG_NAME))
      ],
    ));
  }
}
