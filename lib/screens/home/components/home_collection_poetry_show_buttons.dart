import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';

class CollectionPoetryShowButtons extends StatelessWidget {
  final int themeId;
  final Map<String, dynamic> poetry;

  CollectionPoetryShowButtons({Key key, this.poetry, this.themeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: size.width,
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(Icons.music_note),
              color: themeColor[themeId]['textColor'],
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.comment),
              color: themeColor[themeId]['textColor'],
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.feedback),
              color: themeColor[themeId]['textColor'],
              onPressed: () {},
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.share),
              color: themeColor[themeId]['textColor'],
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
