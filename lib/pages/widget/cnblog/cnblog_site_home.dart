import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/cnblog_site_home_entity.dart';
import 'package:flutter_blog/net/cnblog_service.dart';
import 'package:flutter_blog/tool/route_tool.dart';

import '../article_ui_widget.dart';
import '../banner_wiget.dart';

/// 博客园的首页，其中需要token，真的是服了博客园的API说明文档，竟然不写清楚mmp
class CnblogSiteHome extends StatefulWidget {
  String TOKEN;

  @override
  _CnblogSiteHomeState createState() => _CnblogSiteHomeState();

  CnblogSiteHome(this.TOKEN);
}

class _CnblogSiteHomeState extends State<CnblogSiteHome> {
  // 首页的数据
  List<CnblogSiteHomeEntity> _datas;
  ScrollController _controller;
  int _page = 1;
  CnblogNetService _cnblogNetService;

  @override
  void initState() {
    _datas = new List();
    _controller = ScrollController();
    _cnblogNetService = CnblogNetService();
    // 获取数据
    _getData();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getData,
        child: ListView.builder(
          itemCount: _datas.length,
          itemBuilder: articleView,
          controller: _controller,
        ),
      ),
    );
  }

  // 获得数据
  Future<Null> _getData() {
    _page = 1;
    _datas.clear();
    _cnblogNetService.getHomeSite(_page, 10, widget.TOKEN,
        (CnblogSiteHomeList cnblogSiteHomeList) {
      setState(() {
        _datas.addAll(cnblogSiteHomeList.data);
      });
    });
  }

  Future<Null> _getMore() {
    _page++;
    _cnblogNetService.getHomeSite(_page, 10, widget.TOKEN,
        (CnblogSiteHomeList cnblogSiteHomeList) {
      setState(() {
        _datas.addAll(cnblogSiteHomeList.data);
      });
    });
  }

  Widget articleView(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: 200,
        child: BannerWidgetUI(),
      );
    }
    // 设置文章标题数据
    if (index - 1 < _datas.length) {
      // InkWell水波纹数据
      return new InkWell(
        onTap: () {
          RouteTool.toWebView(
              context, _datas[index - 1].title, _datas[index - 1].url);
        },
        child: CnblogCardView(_datas[index - 1]),
      );
    }
    // 页面底部刷新
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
