import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:Verses/contants.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PoetryCard extends StatefulWidget {
  PoetryCard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PoetryCardState();
  }
}

class PoetryCardState extends State<PoetryCard> {
  Map<String, dynamic> poetry = Map<String, dynamic>();
  bool isLike = false;

  @override
  void initState() {
    super.initState();
    getPoetry(true);
  }

  // 获取每天随机的诗词
  void getPoetry(bool isDay) async {
    var httpClient = HttpClient();
    var url = urlPoetry + 'randomDay';
    print(url);
    if (!isDay) {
      url = urlPoetry + 'random';
    }
    bool result = false;
    var todayPoetry;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var poetryResult = await response.transform(utf8.decoder).join();
        todayPoetry = json.decode(poetryResult);
        result = true;
      } else {
        result = false;
      }
    } catch (exception) {
      result = false;
    }

    // 如果成功
    if (result && todayPoetry.length > 0) {
      isLike = _isLike(todayPoetry[0]);
      setState(() {
        this.poetry = todayPoetry[0];
      });
    }
  }

  // 判断诗词是否已经收藏
  bool _isLike(Map<String, dynamic> poe) {
    return false;
  }

  // 收藏诗词
  void _collection() async {
    // 读取保存的文件
    String dirStr = (await getExternalStorageDirectory()).path;
    String fileName = "like.json";
    File file = File('$dirStr/$fileName');

    if (!file.existsSync()) {
      file.createSync();

      File file1 = await file.writeAsString("dew");
      if (file1.existsSync()) {
        print("save success");
      }
    }

    if (isLike) {
      // 从收藏删除
    } else {
      // 添加到收藏
    }

    setState(() {
      isLike = !isLike;
    });
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
    // 如果没有诗词不显示卡片
    if (this.poetry.isEmpty) {
      return Container();
    }
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
                onPressed: _collection,
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
