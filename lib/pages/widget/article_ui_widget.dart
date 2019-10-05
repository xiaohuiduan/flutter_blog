import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/model/data_model/cnblogs_model/cnblog_site_home_entity.dart';
import 'package:flutter_blog/model/data_model/wanandroid_article_model_entity.dart';
import 'package:flutter_blog/tool/time_tool.dart';

/// 卡片形状的 标题
class ArticleCardWidget extends StatefulWidget {
  // 数据
  Article data;

  ArticleCardWidget(this.data);

  @override
  _ArticleCardWidgetState createState() => _ArticleCardWidgetState();
}

class _ArticleCardWidgetState extends State<ArticleCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  Icon(Icons.insert_emoticon),
                  Text(
                    widget.data.author,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                      child: Text(
                    TimelineUtil.format(widget.data.publishTime),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12),
                  )),
                ],
              )),
          Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    widget.data.title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ))
                ],
              )),
          Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Text(
                    widget.data.superChapterName,
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class CnblogCardView extends StatefulWidget {
  CnblogSiteHomeEntity data;

  @override
  _CnblogCardViewState createState() => _CnblogCardViewState();

  CnblogCardView(this.data);
}

class _CnblogCardViewState extends State<CnblogCardView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                      radius: 10.0,
                      backgroundImage: NetworkImage(widget.data.avatar)),
                  Text(
                    widget.data.author,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                      child: Text(
                    widget.data.postDate,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12),
                  )),
                ],
              )),
          Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    widget.data.title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ))
                ],
              )),
          Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Icon(Icons.chrome_reader_mode),
                  Text(
                    widget.data.viewCount.toString(),
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
