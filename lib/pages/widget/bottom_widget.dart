import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarDemo extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChanged;

  BottomNavigationBarDemo({Key key, this.index: 0, @required this.onChanged})
      : super(key: key);

  @override
  _BottomNavigationBarDemoState createState() =>
      _BottomNavigationBarDemoState();
}

class _BottomNavigationBarDemoState extends State<BottomNavigationBarDemo> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: _onTapHandle,
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.blueAccent,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.android), title: Text("玩Android")),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books), title: Text("公众号")),
        BottomNavigationBarItem(icon: Icon(Icons.toys), title: Text("博客园")),
      ],
    );
  }

  void _onTapHandle(int index) {
    widget.onChanged(index);
  }
}
