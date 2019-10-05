import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/model/data_model/wanandroid_article_model_entity.dart';
import 'package:flutter_blog/model/data_model/wx_article_list_entity.dart';
import 'package:flutter_blog/net/WanAndroidService.dart';
import 'package:flutter_blog/pages/widget/article_ui_widget.dart';
import 'package:flutter_blog/tool/route_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WxArticlePage extends StatefulWidget {
  @override
  _WxArticlePageState createState() => _WxArticlePageState();
}

class _WxArticlePageState extends State<WxArticlePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // 所有公众号的数据
  List<WxArticleListData> _datas = new List();

  // 公共号的具体数据
  Map<int, List<Article>> wxDetailMsgMap;

  // 公众号的翻页情况
  Map<int, int> pageMap;

  // tab端的控制器
  TabController _tabController;

  WanAndroidService wanAndroidService = new WanAndroidService();

  /// 初始化数据
  Future<Null> initData() async {
    wanAndroidService.getWxArticleList((WxArticleListEntity entity) {
      setState(() {
        _datas = entity.data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // 同步控制器
    _tabController = new TabController(
      vsync: this,
      length: _datas.length,
    );

    return Scaffold(
      appBar: appBarWidget(),
      body: new TabBarView(
        controller: _tabController,
        children: _datas.map((item) {
          return NewsList(
            id: item.id,
          );
        }).toList(),
      ),
    );
  }

  Widget appBarWidget() {
    return AppBar(
      elevation: 0.4,
      title: TabBar(
        controller: _tabController,
        tabs: _datas.map((WxArticleListData item) {
          return Tab(text: item.name);
        }).toList(),
        isScrollable: true,
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  final int id;

  @override
  _NewsListState createState() => _NewsListState();

  NewsList({Key key, this.id}) : super(key: key);
}

class _NewsListState extends State<NewsList>
    with AutomaticKeepAliveClientMixin {
  List<Article> _datas = new List();

  // 滑动的控制器
  ScrollController _scrollController = ScrollController();

  WanAndroidService wanAndroidService = new WanAndroidService();
  int _page = 0;

  Future<Null> _getData() async {
    _page = 0;
    _datas.clear();
    wanAndroidService.getWxArticle((ArticleModel articleModel) {
      setState(() {
        _datas = articleModel.data.datas;
      });
    }, widget.id, _page);
  }

  Future<Null> _getMore() async {
    _page++;
    wanAndroidService.getWxArticle((ArticleModel articleModel) {
      setState(() {
        _datas.addAll(articleModel.data.datas);
      });
    }, widget.id, _page);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: RefreshIndicator(
        onRefresh: _getData,
        child: ListView.builder(
          itemBuilder: _wxTitle,
          itemCount: _datas.length + 1,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget _wxTitle(BuildContext context, int index) {
    // 设置文章标题数据
    if (index < _datas.length) {
      // InkWell水波纹数据
      return new InkWell(
        onTap: () {
          RouteTool.toWebView(context, _datas[index].title, _datas[index].link);
        },
        child: ArticleCardWidget(_datas[index]),
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
