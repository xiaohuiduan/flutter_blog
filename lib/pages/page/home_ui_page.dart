import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blog/model/data_model/wanandroid_article_model_entity.dart';
import 'package:flutter_blog/net/WanAndroidService.dart';
import 'package:flutter_blog/pages/widget/banner_wiget.dart';
import 'package:flutter_blog/pages/widget/article_ui_widget.dart';
import 'package:flutter_blog/tool/route_tool.dart';

class HomePageUI extends StatefulWidget {
  @override
  _HomePageUIState createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI>
    with AutomaticKeepAliveClientMixin {
  List<Article> _datas = new List();
  ScrollController _controller = ScrollController();
  int _page = 0;
  WanAndroidService wanAndroidService = new WanAndroidService();

  @override
  void initState() {
    super.initState();
    getData();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  Future<Null> getData() {
    wanAndroidService.getArticleList((ArticleModel model) {
      setState(() {
        _datas.clear();
        _datas.addAll(model.data.datas);
      });
    }, _page);
  }

  Future<Null> _getMore() {
    _page++;
    wanAndroidService.getArticleList((ArticleModel model) {
      setState(() {
        _datas.addAll(model.data.datas);
      });
    }, _page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getData,
        child: ListView.builder(
          itemCount: _datas.length,
          itemBuilder: articleView,
          controller: _controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
              context, _datas[index - 1].title, _datas[index - 1].link);
        },
        child: ArticleCardWidget(_datas[index - 1]),
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

  @override
  bool get wantKeepAlive => true;
}
