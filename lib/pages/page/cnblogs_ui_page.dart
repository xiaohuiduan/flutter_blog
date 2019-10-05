import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cnblog_my_ui_page.dart';

class CnBlogsUIPage extends StatefulWidget {
  @override
  _CnBlogsUIPageState createState() => _CnBlogsUIPageState();
}

class _CnBlogsUIPageState extends State<CnBlogsUIPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 同步控制器
    return Scaffold(body: CnblogLoginWeb());
  }
}
