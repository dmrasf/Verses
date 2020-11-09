import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:Verses/contants.dart';
import 'dart:io';
import 'package:Verses/components/poetry_list_and_item.dart';
import 'package:Verses/screens/result/components/poetry_item_show.dart';
import 'package:Verses/screens/result/components/search_remind.dart';

class ResultScreen extends StatefulWidget {
  final String authorString;
  final String dynastyString;
  final String titleString;
  final String contentString;

  const ResultScreen({
    Key key,
    this.authorString,
    this.dynastyString,
    this.titleString,
    this.contentString,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ResultScreenState(
        authorString: this.authorString,
        dynastyString: this.dynastyString,
        titleString: this.titleString,
        contentString: this.contentString);
  }
}

class ResultScreenState extends State<ResultScreen> {
  final String authorString;
  final String dynastyString;
  final String titleString;
  final String contentString;
  // 存放搜索到的诗词
  List<Map<String, dynamic>> poetries = [];
  Widget body;

  ResultScreenState({
    this.authorString,
    this.dynastyString,
    this.titleString,
    this.contentString,
  });

  @override
  void initState() {
    super.initState();
    getPoetry(true);
  }

  void getPoetry(bool isDay) async {
    var httpClient = HttpClient();
    bool isRightUrl = false;

    // 生成url
    var url = urlPoetry + 'search?';
    if (this.authorString.length > 0) {
      url = url + 'author=' + this.authorString + '&';
    }
    if (this.titleString.length > 0) {
      url = url + 'title=' + this.titleString + '&';
    }
    if (this.dynastyString.length > 0) {
      url = url + 'dynasty=' + this.dynastyString + '&';
    }
    if (this.contentString.length > 0) {
      url = url + 'content=' + this.contentString + '&';
    }

    if (url[url.length - 1] == '&') {
      url = url.substring(0, url.length - 1);
      isRightUrl = true;
    }

    bool result = false;
    var searchPoetry;

    // 如果url是正确的
    if (isRightUrl) {
      // 先显示等待查询页面
      setState(() {
        this.body = SearchRemind(reminds: "稍等");
      });
      try {
        var request = await httpClient.getUrl(Uri.parse(url));
        var response = await request.close();
        if (response.statusCode == 200) {
          var poetryResult = await response.transform(utf8.decoder).join();
          searchPoetry = json.decode(poetryResult);
          result = true;
        } else {
          result = false;
        }
      } catch (exception) {
        result = false;
      }
    }

    // 如果成功 显示查询的诗词列表
    if (result && searchPoetry.length > 0) {
      for (var i = 0, len = searchPoetry.length; i < len; ++i) {
        this.poetries.add(searchPoetry[i]);
      }
      setState(() {
        this.body = PoetryListView(
          poetries: this.poetries,
          poetryItem: (poetry) => PoetryItemShow(poetry: poetry),
        );
      });
    } else if (result) {
      // 显示未查询到结果
      setState(() {
        this.body = SearchRemind(reminds: "无结果");
      });
    } else {
      // url 无效
      setState(() {
        this.body = SearchRemind(reminds: "输入");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.body,
    );
  }
}
