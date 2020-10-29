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
    var httpClient = HttpClient();
    var url = 'http://207.246.94.85:8084/files.json';
    bool result = false;
    var files;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      print(response.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        var filesResult = await response.transform(utf8.decoder).join();
        files = json.decode(filesResult);
        result = true;
      } else {
        result = false;
      }
    } catch (exception) {
      result = false;
    }

    // 如果获取到文件名
    if (result) {
      for (var i = 0, len = files.length; i < len; ++i) {
        await _saveFile(files[i]).then((r) => {if (r) {} else {}});
      }
    }
  }

  // 根据解析到的html 文件名判断并保存
  Future<bool> _saveFile(String fileName) async {
    // 判断文件是否存在
    String dirStr = (await getExternalStorageDirectory()).path;

    File file = File('$dirStr/$fileName');
    bool result = false;

    if (!file.existsSync()) {
      file.createSync();
      print("$fileName not exit");

      // 不存在进行下载操作
      var httpClient = HttpClient();
      var url = 'http://207.246.94.85:8084/' + fileName;
      try {
        var request = await httpClient.getUrl(Uri.parse(url));
        var response = await request.close();
        print(response.statusCode);
        if (response.statusCode == HttpStatus.ok) {
          var jsonR = await response.transform(utf8.decoder).join();
          File file1 = await file.writeAsString(jsonR);
          if (file1.existsSync()) {
            print("save success");
            result = true;
          }
        } else {
          result = false;
        }
      } catch (exception) {
        result = false;
      }
    } else
      print("exit");
    return result;
  }
}
