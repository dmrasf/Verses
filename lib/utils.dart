import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<InlineSpan> getContent(Map<String, dynamic> poetry) {
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
    ));
  }

  return contents;
}

// 根据判断收藏  返回是否诗词现在状态
Future<bool> collectionToggle(Map<String, dynamic> poetry) async {
  var res = await isPoetryCollection(poetry);
  File file = File(res[1]);

  if (res[0]) {
    // 如果文件存在  删除
    file.deleteSync();
    return false;
  } else {
    var cfile = await file.create();
    File wfile = await cfile.writeAsString(jsonEncode(poetry));
    if (wfile.existsSync()) {
      return true;
    } else {
      return false;
    }
  }
}

// 判断诗词是否已经收藏
Future<List> isPoetryCollection(Map<String, dynamic> poetry) async {
  // 读取保存的文件
  String dirStr = (await getExternalStorageDirectory()).path;

  var bytes = utf8.encode(poetry['作者'] + poetry["内容"] + poetry["朝代"] + poetry["题目"]);
  var digest = sha1.convert(bytes);

  String fileName = dirStr + '/' + digest.toString() + ".json";
  File file = File('$fileName');

  if (!file.existsSync()) {
    return [false, fileName];
  } else {
    return [true, fileName];
  }
}

String poetryToString(Map<String, dynamic> poetry) {
  var bytes = utf8.encode(poetry['作者'] + poetry["内容"] + poetry["朝代"] + poetry["题目"]);
  var digest = sha1.convert(bytes);
  return digest.toString();
}

Future<List<Map<String, dynamic>>> getCollection() async {
  List<Map<String, dynamic>> poetries = [];
  // 读取保存的文件
  String dirStr = (await getExternalStorageDirectory()).path;
  Directory dir = Directory(dirStr);

  // 对每个文件操作
  List<FileSystemEntity> files = dir.listSync(recursive: true);
  for (final f in files) {
    File file = File(f.path);
    String poeStr = await file.readAsString();
    var poetry = jsonDecode(poeStr);
    poetries.add(poetry);
  }
  return poetries;
}

class SharedPreferencesUtil {
  static setData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (T) {
      case String:
        prefs.setString(key, value as String);
        break;
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
    }
  }

  static Future<T> getData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic res;
    switch (T) {
      case String:
        res = prefs.getString(key) as T;
        break;
      case bool:
        res = prefs.getBool(key) as T;
        break;
      case int:
        res = prefs.getInt(key) as T;
        break;
      case double:
        res = prefs.getDouble(key) as T;
        break;
    }
    return res;
  }
}
