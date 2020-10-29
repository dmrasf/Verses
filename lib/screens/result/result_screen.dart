import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:Verses/contants.dart';
import 'dart:io';
import 'package:Verses/contants.dart';

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
    } else {
      return;
    }

    print(url);

    bool result = false;
    var searchPoetry;

    //try {
    //var request = await httpClient.getUrl(Uri.parse(url));
    //var response = await request.close();
    //if (response.statusCode == 200) {
    //var poetryResult = await response.transform(utf8.decoder).join();
    //searchPoetry = json.decode(poetryResult);
    //result = true;
    //} else {
    //result = false;
    //}
    //} catch (exception) {
    //result = false;
    //}

    //// 如果成功
    //if (result && searchPoetry.length > 0) {
    //print(searchPoetry);
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(this.authorString),
            Text(this.dynastyString),
            Text(this.titleString),
            Text(this.contentString),
          ],
        ),
      ),
    );
  }
}
