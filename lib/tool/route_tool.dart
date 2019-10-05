import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class RouteTool {
  static void toWebView(BuildContext context, String title, String link) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new WebViewPageUI(
        title: title,
        url: link,
      );
    }));
  }

  static Future push(BuildContext context, Widget widget) {
    Future result = Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));
    return result;
  }
}

class WebViewPageUI extends StatefulWidget {
  String title;
  String url;
  Map headers;

  WebViewPageUI(
      {Key key, @required this.title, @required this.url, this.headers})
      : super(key: key);

  @override
  _WebViewPageUIState createState() => _WebViewPageUIState();
}

class _WebViewPageUIState extends State<WebViewPageUI> {
  bool isLoad = true;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
}
