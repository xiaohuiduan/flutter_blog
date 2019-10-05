import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_blog/net/cnblog_service.dart';
import 'package:flutter_blog/static_msg/StaticMsg.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

//第三方认证页面操作
class CnBlogRouteTool {
  static void toWebView(BuildContext context, String title, String link) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new WebViewPageUI(
        title: title,
        url: link,
      );
    }));
  }
}

// 进行认证的界面
class WebViewPageUI extends StatefulWidget {
  String title;
  String url;

  WebViewPageUI({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  _WebViewPageUIState createState() => _WebViewPageUIState();
}

class _WebViewPageUIState extends State<WebViewPageUI> {
  bool isLoad = true;
  bool isLoadingCallbackPage = false;
  RegExp mobile = new RegExp(r"(?<=access_token:).*?(?=,)");
  CnblogNetService _cnblogNetService;
  Future<SharedPreferences> _prefs;

  // WebView加载状态变化监听器
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    _cnblogNetService = new CnblogNetService();
    _prefs = SharedPreferences.getInstance();
    // 监听页面跳转
    flutterWebViewPlugin.onUrlChanged.listen((url) {
      // 该页面会接收code，然后根据code换取AccessToken，并将获取到的token及其他信息，通过js的get()方法返回
      if (url != null && url.length > 0 && url.contains("code=")) {
        setState(() {
          isLoadingCallbackPage = true;
        });
        parseResult();
      }
    });
    // 监听页面状态改变
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingCallbackPage) {
      return Home();
    }
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        elevation: 0.4,
        title: new Text(widget.title),
        bottom: new PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: isLoad
                ? new LinearProgressIndicator()
                : new Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  )),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }

  /// 存储数据
  parseResult() {
    flutterWebViewPlugin.evalJavascript("code_value").then((code) {
      if (code != null && code.length != 0) {
        _cnblogNetService.getToken(code, storageToken);
      }
    });
  }

  storageToken(token) async {
    _prefs.then((spf) {
      spf.setString(StaticMsg.TOKEN_KEY, token);
    });
  }
}
