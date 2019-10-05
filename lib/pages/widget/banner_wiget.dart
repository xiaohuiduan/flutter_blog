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
    return Swiper(
      itemCount: 34,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {},
          child: new Container(
            child: new Image.asset(
              "image/$index.jpg",
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}

class CnblogAppBar extends StatefulWidget {
  @override
  _CnblogAppBarState createState() => _CnblogAppBarState();
}

class _CnblogAppBarState extends State<CnblogAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
