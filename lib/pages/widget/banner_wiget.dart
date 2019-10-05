import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidgetUI extends StatefulWidget {
  @override
  _BannerWidgetUIState createState() => _BannerWidgetUIState();
}

class _BannerWidgetUIState extends State<BannerWidgetUI> {
  @override
  Widget build(BuildContext context) {
	  return Container(
		  child: new Image.network(
			  "https://api.xygeng.cn/bing/1366.php",
			  fit: BoxFit.fill,
		  ),
    );
  }
}

