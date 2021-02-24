import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';
import 'package:Verses/contants.dart';

class SearchPoetryShowLikeButton extends StatefulWidget {
  final Map<String, dynamic> poetry;
  final int themeId;
  SearchPoetryShowLikeButton({Key key, this.poetry, this.themeId}) : super(key: key);
  @override
  _SearchPoetryShowLikeButtonState createState() => _SearchPoetryShowLikeButtonState();
}

class _SearchPoetryShowLikeButtonState extends State<SearchPoetryShowLikeButton> {
  bool isLike = false;
  bool tmpIsLike;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    this.isLike = (await isPoetryCollection(widget.poetry))[0];
    this.tmpIsLike = this.isLike;
    setState(() {});
  }

  void _press() async {
    this.tmpIsLike = this.tmpIsLike ? false : true;
    setState(() {});
  }

  @override
  void deactivate() {
    if (this.tmpIsLike != this.isLike) {
      collectionToggle(widget.poetry);
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
        width: size.width,
        height: size.height * 0.08,
        alignment: Alignment.center,
        child: tmpIsLike ? Text('Unlike') : Text('Like'),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: tmpIsLike ? Colors.red : themeColor[widget.themeId]['primaryColor'],
        ),
      ),
      onTap: _press,
    );
  }
}
