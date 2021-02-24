import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';

class CollectionPoetryShowButtons extends StatelessWidget {
  final int themeId;
  final Map<String, dynamic> poetry;
  BuildContext cnt;
  Size size;

  CollectionPoetryShowButtons({Key key, this.poetry, this.themeId}) : super(key: key);

  Widget getToolButton(IconData icon, Function _press) {
    return FlatButton(
      height: size.height * 0.1,
      padding: EdgeInsets.all(0),
      child: Icon(icon, color: themeColor[this.themeId]['textColor']),
      color: themeColor[themeId]['primaryColor'],
      onPressed: _press,
    );
  }

  @override
  Widget build(BuildContext context) {
    this.cnt = context;
    this.size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: size.width,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 8),
      decoration: BoxDecoration(
        color: themeColor[this.themeId]['primaryColor'],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: getToolButton(Icons.music_note, this.funcPlay),
          ),
          Expanded(
            child: getToolButton(Icons.comment, this.funcComment),
          ),
          Expanded(
            child: getToolButton(Icons.feedback, this.funcFeedback),
          ),
          Expanded(
            child: getToolButton(Icons.share, this.funcShare),
          ),
        ],
      ),
    );
  }

  void funcPlay() {}
  void funcComment() {}
  void funcFeedback() {}
  void funcShare() {}
}
