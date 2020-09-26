import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:Verses/contants.dart';

import 'package:flutter_svg/flutter_svg.dart';

class PoetryCard extends StatefulWidget {
  PoetryCard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PoetryCardState();
  }
}

class _PoetryCardState extends State<PoetryCard> {
  _PoetryCardState({Key key}) {
    poetry = _randomPoetry();
  }

  Map<String, dynamic> poetry;
  bool isLike = false;

  Map<String, dynamic> _randomPoetry() {
    String poetryJson =
        '{ "题目": "红楼梦十二曲 收尾 其十四 飞鸟各投林", "朝代": "清", "作者": "曹雪芹", "内容": "为官的家业凋零，富贵的金银散尽。有恩的死里逃生，无情的分明报应。欠命的命已还，欠泪的泪已尽：冤冤相报自非轻，分离聚合皆前定。欲知命短问前生，老来富贵也真侥幸。看破的遁入空门，痴迷的枉送了性命。好一似食尽鸟投林，落了片白茫茫大地真干净！" }';
    Map<String, dynamic> poe = json.decode(poetryJson);

    return poe;
  }

  void press() {
    setState(() {
      isLike = !isLike;
      poetry = _randomPoetry();
    });

    if (isLike) {
      // TODO:
    }
  }

  List<InlineSpan> _getContent() {
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
                    fontSize: 12,
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: size.width * 0.5,
                child: Text(
                  "${poetry['题目']}",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
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
                children: _getContent(),
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
