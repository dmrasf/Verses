import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:verses/contants.dart';
import 'package:device_info/device_info.dart';

List<InlineSpan> getContent(Map<String, dynamic> poetry, {int poetryShowType}) {
  String content = poetry["内容"];
  String pattern = "。：？；！";
  List<String> lines = [];
  String line = "";

  for (var i = 0, len = content.length; i < len; ++i) {
    if (pattern.contains(content[i])) {
      lines.add(line + content[i]);
      line = "";
    } else {
      line = line + content[i];
    }
  }

  List<InlineSpan> contents = [];
  if (poetryShowType == PoetryShowTypes['pinyin']) {
    List<String> pinyinLines = [];
    for (var i = 0; i < lines.length; i++) {
      pinyinLines.add(PinyinHelper.getPinyinE(lines[i],
          separator: ' ', defPinyin: ' ', format: PinyinFormat.WITH_TONE_MARK));
    }
    for (var i = 0, len = lines.length; i < len; ++i) {
      contents.add(TextSpan(
        text: pinyinLines[i] + '\n',
      ));
      contents.add(TextSpan(
        text: lines[i] + '\n',
      ));
    }
  } else if (poetryShowType == PoetryShowTypes['fanti'] ||
      poetryShowType == PoetryShowTypes['all']) {
    List<String> fantiLines = [];
    for (var i = 0; i < lines.length; i++) {
      fantiLines.add(ChineseHelper.convertToTraditionalChinese(lines[i]));
    }
    List<String> pinyinLines = [];
    for (var i = 0; i < lines.length; i++) {
      pinyinLines.add(PinyinHelper.getPinyinE(lines[i],
          separator: ' ', defPinyin: ' ', format: PinyinFormat.WITH_TONE_MARK));
    }
    for (var i = 0; i < lines.length; i++) {
      if (poetryShowType == PoetryShowTypes['all']) {
        contents.add(TextSpan(
          text: pinyinLines[i] + '\n',
        ));
      }
      contents.add(TextSpan(
        text: fantiLines[i] + '\n',
      ));
    }
  } else {
    for (var i = 0; i < lines.length; i++) {
      contents.add(TextSpan(
        text: lines[i] + '\n',
      ));
    }
  }
  return contents;
}

Future<bool> collectionOnline(String poetryStr, String status) async {
  var httpClient = HttpClient();
  String url =
      urlPoetry + 'getlikes?poetrystr=' + poetryStr + '&status=' + status;
  bool result = false;
  var poetryCollectionNumbers;

  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      var poetryResult = await response.transform(utf8.decoder).join();
      poetryCollectionNumbers = json.decode(poetryResult);
      result = true;
    } else {
      result = false;
    }
  } catch (exception) {
    result = false;
  }

  return result;
}

Future<List<Map<String, dynamic>>> getComments(
    String poetryStr, String phoneID) async {
  var httpClient = HttpClient();
  String url =
      urlPoetry + 'getcomments?poetrystr=' + poetryStr + '&phoneid=' + phoneID;
  bool result = false;
  var searchComments;
  List<Map<String, dynamic>> comments = [];

  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      var commentsResult = await response.transform(utf8.decoder).join();
      searchComments = json.decode(commentsResult);
      result = true;
    } else {
      result = false;
    }
  } catch (exception) {
    result = false;
  }

  if (!(!result ||
      searchComments[0].containsKey('error') ||
      searchComments[0].containsKey('warning') ||
      searchComments[0].containsKey('prompt'))) {
    for (var i = 0, len = searchComments.length; i < len; ++i) {
      comments.add(searchComments[i]);
    }
  }

  return comments;
}

Future<bool> addComment(
    String poetryStr, String phoneID, String comment) async {
  String url = urlPoetry +
      'getcomments?poetrystr=' +
      poetryStr +
      '&phoneid=' +
      phoneID +
      '&comment=' +
      comment +
      '&commentstatus=add';

  return await urlClient(url);
}

Future<bool> urlClient(String url) async {
  var httpClient = HttpClient();
  bool result = false;
  var searchResult;

  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      var commentsResult = await response.transform(utf8.decoder).join();
      searchResult = json.decode(commentsResult);
      result = true;
    } else {
      result = false;
    }
  } catch (exception) {
    result = false;
  }

  return result;
}

Future<bool> removeComment(
  String poetryStr,
  String phoneID,
  String commentDate,
  String comment,
) async {
  String url = urlPoetry +
      'getcomments?poetrystr=' +
      poetryStr +
      '&phoneid=' +
      phoneID +
      '&commentdate=' +
      commentDate +
      '&comment=' +
      comment +
      '&commentstatus=remove';

  return await urlClient(url);
}

Future<bool> changeComment(
  String poetryStr,
  String phoneID,
  String commentDate,
  String comment,
) async {
  String url = urlPoetry +
      'getcomments?poetrystr=' +
      poetryStr +
      '&phoneid=' +
      phoneID +
      '&commentdate=' +
      commentDate +
      '&comment=' +
      comment +
      '&commentstatus=change';

  return await urlClient(url);
}

Future<bool> changeCommentLikeStatus(
  String poetryStr,
  String phoneID,
  String likeID,
  String commentDate,
  String likeStatus,
) async {
  String url = urlPoetry +
      'getcomments?poetrystr=' +
      poetryStr +
      '&phoneid=' +
      phoneID +
      '&likeid=' +
      likeID +
      '&commentdate=' +
      commentDate +
      '&likestatus=' +
      likeStatus;

  return await urlClient(url);
}

Future<List<Map<String, dynamic>>> getPoetries(
  String authorString,
  String titleString,
  String dynastyString,
  String contentString,
  String block,
) async {
  var url = urlPoetry + 'search?';
  if (authorString.length > 0) url = url + 'author=' + authorString + '&';
  if (titleString.length > 0) url = url + 'title=' + titleString + '&';
  if (dynastyString.length > 0) url = url + 'dynasty=' + dynastyString + '&';
  if (contentString.length > 0) url = url + 'content=' + contentString + '&';
  if (block.length > 0) url = url + 'block=' + block + '&';
  if (url[url.length - 1] == '&') url = url.substring(0, url.length - 1);

  List<Map<String, dynamic>> poetries = [];
  bool result = false;
  var searchPoetry;

  var httpClient = HttpClient();
  try {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      var commentsResult = await response.transform(utf8.decoder).join();
      searchPoetry = json.decode(commentsResult);
      result = true;
    } else {
      result = false;
    }
  } catch (exception) {
    result = false;
  }

  if (result) {
    for (var i = 0, len = searchPoetry.length; i < len; ++i) {
      poetries.add(searchPoetry[i]);
    }
  }
  return poetries;
}

Future<Map<String, dynamic>> getPoetry(bool isDay) async {
  Map<String, dynamic> poetry = Map<String, dynamic>();
  var url = urlPoetry + 'randomDay';
  bool result = false;
  var todayPoetry;
  if (!isDay) {
    url = urlPoetry + 'random';
  }

  var httpClient = HttpClient();
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
  if (result && todayPoetry.length > 0) poetry = todayPoetry[0];

  return poetry;
}

// 根据判断收藏  返回是否诗词现在状态
Future<bool> collectionToggle(Map<String, dynamic> poetry) async {
  var res = await isPoetryCollection(poetry);
  File file = File(res[1]);

  if (res[0]) {
    // 如果文件存在  删除
    file.deleteSync();
    await collectionOnline(poetryToString(poetry), 'remove');
    return false;
  } else {
    var cfile = await file.create();
    File wfile = await cfile.writeAsString(jsonEncode(poetry));
    if (wfile.existsSync()) {
      await collectionOnline(poetryToString(poetry), 'add');
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

  var bytes =
      utf8.encode(poetry['作者'] + poetry["内容"] + poetry["朝代"] + poetry["题目"]);
  var digest = sha1.convert(bytes);

  String fileName = dirStr + '/' + "p" + digest.toString() + ".json";
  File file = File('$fileName');

  if (!file.existsSync()) {
    return [false, fileName];
  } else {
    return [true, fileName];
  }
}

String poetryToString(Map<String, dynamic> poetry) {
  var bytes =
      utf8.encode(poetry['作者'] + poetry["内容"] + poetry["朝代"] + poetry["题目"]);
  var digest = sha1.convert(bytes);
  return "p" + digest.toString();
}

Future<List<Map<String, dynamic>>> getCollection() async {
  List<Map<String, dynamic>> poetries = [];
  // 读取保存的文件
  String dirStr = (await getExternalStorageDirectory()).path;
  Directory dir = Directory(dirStr);

  // 对每个文件操作
  List<FileSystemEntity> files = dir.listSync(recursive: false);
  for (final f in files) {
    FileSystemEntityType type = await FileSystemEntity.type(f.path);
    if (type == FileSystemEntityType.file) {
      File file = File(f.path);
      String poeStr = await file.readAsString();
      Map<String, dynamic> poetry = jsonDecode(poeStr);
      if (poetry.containsKey('题目') &&
          poetry.containsKey('内容') &&
          poetry.containsKey('作者') &&
          poetry.containsKey('朝代')) poetries.add(poetry);
    }
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

Future<String> getUniqueId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId;
  }
}
