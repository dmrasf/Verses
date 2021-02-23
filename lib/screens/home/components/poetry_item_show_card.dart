import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';
import 'package:Verses/contants.dart';

class PoetryItemShowCard extends StatefulWidget {
  final Map<String, dynamic> poetry;
  final int themeId;
  PoetryItemShowCard({Key key, this.poetry, this.themeId}) : super(key: key);
  @override
  _PoetryItemShowCardState createState() => _PoetryItemShowCardState();
}

class _PoetryItemShowCardState extends State<PoetryItemShowCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: size.width,
              padding: EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: Container(
                width: size.width,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: getContent(widget.poetry),
                        style: TextStyle(
                          fontFamily: 'LongCang',
                          fontSize: 20,
                          color: themeColor[widget.themeId]['textColor'],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: size.height * 0.08,
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.grey,
            child: Row(
              children: [],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: themeColor[widget.themeId]['primaryColor'],
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
