import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';

import 'package:flutter_svg/flutter_svg.dart';

class PoetryCard extends StatefulWidget {
  PoetryCard({Key key, this.poetry}) : super(key: key);

  final Map<String, dynamic> poetry;

  @override
  State<StatefulWidget> createState() {
    return _PoetryCardState(poetry: this.poetry);
  }
}

class _PoetryCardState extends State<PoetryCard> {
  _PoetryCardState({Key key, @required this.poetry});

  Map<String, dynamic> poetry;
  bool isLike = false;

  List<InlineSpan> getContent() {
    List<InlineSpan> contents = List<InlineSpan>();
    String content = poetry["内容"];
    String pattern = "。：？；！";
    List<String> lines = List<String>();
    String line = "";

    for (var i = 0, len = content.length; i < len; ++i) {
      if (pattern.contains(content[i])) {
        lines.add(line + content[i] + "\n");
        line = "";
      } else {
        line = line + content[i];
      }
    }

    for (var i = 0, len = lines.length; i < len; ++i) {
      contents.add(TextSpan(
        text: lines[i],
        style: TextStyle(
          color: kTextColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ));
    }

    return contents;
  }

  void press() {
    setState(() {
      isLike = !isLike;
    });

    if (isLike) {
      // TODO:
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 0.5),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding * 0.6,
      ),
      width: size.width * 0.9,
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: "${poetry['作者']}\n${poetry['朝代']}",
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${poetry['题目']}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: press,
                icon: SvgPicture.asset(
                  "assets/icons/heart.svg",
                  height: 20,
                  width: 20,
                  color: isLike ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: getContent(),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: kPirmaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
