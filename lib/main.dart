import 'package:flutter/material.dart';
import 'package:flutter_blog/pages/page/cnblogs_ui_page.dart';
import 'package:flutter_blog/pages/page/home_ui_page.dart';
import 'package:flutter_blog/pages/widget/bottom_widget.dart';
import 'package:flutter_blog/pages/page/wxArticle_ui_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final _pageController = PageController();
  int _pageIndex = 0;
  var _titleList = [
    "玩Android",
    "公众号",
    "博客园",
  ];
  var _pageList;

  @override
  void initState() {
    _pageList = [
      HomePageUI(),
      WxArticlePage(),
      CnBlogsUIPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: PageView(
        children: _pageList,
        onPageChanged: _handleTabChanged,
        controller: _pageController,
      ),
//          appBar: _appBarWeight(context),
      bottomNavigationBar: BottomNavigationBarDemo(
        index: _pageIndex,
        onChanged: _handleTabChanged,
      ),
    ));
  }

  Widget _appBarWeight(BuildContext context) {
    return AppBar(
      title: Text(
        _titleList[_pageIndex],
        textAlign: TextAlign.center,
      ),
    );
  }

  void _handleTabChanged(int index) {
    setState(() {
      if (_pageIndex != index) {
        _pageIndex = index;
      }
    });
    _pageController.jumpToPage(_pageIndex);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
