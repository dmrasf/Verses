import 'package:flutter/material.dart';
import 'package:Verses/screens/home/components/title_and_search.dart';
import 'package:Verses/screens/home/components/poetry_card.dart';
import 'package:Verses/screens/home/components/home_communication.dart';
import 'package:Verses/screens/home/components/today_and_more.dart';
import 'package:Verses/screens/home/components/icon_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TitleAndSearch(),
                TodayPoetryAndMore(),
                PoetryCard(key: keyValue),
              ],
            ),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        iconSize: 8,
        // 打开收藏
        onPressed: () {},
        icon: SvgPicture.asset(
          "assets/icons/heart.svg",
          height: 20,
          width: 20,
        ),
      ),
      actions: [
        //IconButton(
        //iconSize: 8,
        //onPressed: _downloadPoetry,
        //icon: SvgPicture.asset(
        //"assets/icons/download.svg",
        //height: 20,
        //width: 20,
        //color: Colors.black,
        //),
        //),
        IconChangeTheme(),
      ],
    );
  }

  // 从服务器下载诗词数据
  void _downloadPoetry() async {
    /* 获取文件名html


       解析html

       for 每个文件名
         判断是否已有本地文件
         if true
           continue
         else 
           下载到本地    
       endfor

       提示用户下载完成 */

    var httpClient = HttpClient();
    var url = 'http://207.246.94.85:8084';
    bool result = false;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      print(response.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        var htmlResult = await response.transform(utf8.decoder).join();
        result = true;
      } else {
        result = false;
      }
    } catch (exception) {
      result = false;
    }

    // 如果获取到文件名
    if (result) {
      List<String> fileNames = List<String>();

      for (var i = 0, len = fileNames.length; i < len; ++i) {
        _saveFile(fileNames[i]).then((r) => {if (r) {} else {}});
      }
    }
  }

  // 根据解析到的html 文件名判断并保存
  Future<bool> _saveFile(String fileName) async {
    var httpClient = HttpClient();
    var url = 'http://207.246.94.85:8084/' + fileName;
    bool result = false;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      print(response.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        var jsonR = await response.transform(utf8.decoder).join();
        var data = json.decode(jsonR);
        result = true;
      } else {
        result = false;
      }
    } catch (exception) {
      result = false;
    }

    return result;
  }
}
