import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:Verses/contants.dart';
import 'package:Verses/utils.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Verses/screens/home/components/poetry_item_show_col.dart';

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
      // 将红心变成红色
      this.isLike = (await isPoetryCollection(todayPoetry[0]))[0];
      setState(() {
        this.poetry = todayPoetry[0];
      });
    }
  }

  // 收藏诗词
  void _pressCol() async {
    // 读取保存的文件
    this.isLike = await collectionToggle(this.poetry);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // 如果没有诗词不显示卡片
    if (this.poetry.isEmpty) {
      return Container();
    }
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PoetryItemShowForCol(
                  poetry: this.poetry,
                ),
              ),
            );
          },
          child: Container(
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
                          color: themeColor[themeId]["textColor"],
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
                      onPressed: _pressCol,
                      icon: SvgPicture.asset("assets/icons/heart.svg",
                          height: 20,
                          width: 20,
                          color: isLike ? Colors.red : themeColor[themeId]['backgroundColor']),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: getContent(this.poetry),
                      style: TextStyle(color: themeColor[themeId]['textColor']),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: themeColor[themeId]["primaryColor"],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
