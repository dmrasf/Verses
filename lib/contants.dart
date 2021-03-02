import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

final keyForCard = GlobalKey();
final keyForQrCode = GlobalKey();
const double kDefaultPadding = 20.0;
const String urlPoetry = 'https://dmrasf.com:7777/poetry/';
const Map PoetryShowTypes = {'normal': 1, 'pinyin': 2, 'fanti': 3, 'all': 4};
const Map PairTypes = {'addtime': 1, 'addtimeN': 2, 'author': 3, 'dynasty': 4};
const Map themeColor = {
  0: {
    //white
    'primaryColor': Color(0xffffffff),
    'backgroundColor': Color(0xfff3f3f3),
    'buttonColor': Colors.black,
    'textColor': Colors.black,
    'buttonSvg': 'assets/icons/moon.svg',
    'commentBackgroundColor': Color(0xffe9e9eb),
    'backTextColor': Color(0x30000000),
    'overlayColor': Color(0x10000000),
  },
  1: {
    //black
    'primaryColor': Color(0xff2a2a2a),
    'backgroundColor': Color(0xff000000),
    'buttonColor': Colors.white,
    'textColor': Colors.white,
    'buttonSvg': 'assets/icons/sun.svg',
    'commentBackgroundColor': Color(0xff161820),
    'backTextColor': Color(0x30ffffff),
    'overlayColor': Color(0x10ffffff),
  },
};

class VersesLocalizations {
  final Locale locale;

  VersesLocalizations(this.locale);

  static VersesLocalizations of(BuildContext context) {
    return Localizations.of<VersesLocalizations>(context, VersesLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'heading': 'Search Verses',
      'search': 'Search',
      'todayPoetry': 'Today Poetry',
      'change': 'Next',
      'addTime': 'Date',
      'author': 'Author',
      'dynasty': 'Dynasty',
      'title': 'Title(Separate multiple search terms with a space)',
      'content': 'Content(Separate multiple search terms with a space)',
      'dismissed': 'Dismissed!',
      'copied': 'Copied!',
      'searchError': '数据库启动失败！',
      'searchWarning': '根据关键词无法找到相关诗词！',
      'searchWait': '稍等，正在查询中！',
      'searchReinput': '请重新输入搜索词！',
      'likesNum': 'Number of Likes: ',
      'commentsNum': 'Number of Comments: ',
      'commentsNew': 'Latest Comments',
      'commentsTop': 'Top Comments',
      'noComments': 'No Comments',
      'inputComment': 'Input Comment',
      'deleteComment': 'Delete',
      'changeComment': 'Change',
      'confirm': 'Confirm',
      'cancel': 'Cancel',
      'noNetWork': 'No NetWork',
      'save': 'save',
      'saveCode': 'Scan QR Code',
      'findpoetry': '查找诗词',
    },
    'zh': {
      'heading': '诗词搜索',
      'search': '搜索',
      'todayPoetry': '今日诗词',
      'change': '下一首',
      'addTime': '时间',
      'author': '作者',
      'dynasty': '朝代',
      'title': '题目(多个搜索词请用空格分开)',
      'content': '内容(多个搜索词请用空格分开)',
      'dismissed': '已被移除！',
      'copied': '已复制！',
      'searchError': '数据库启动失败！',
      'searchWarning': '根据关键词无法找到相关诗词！',
      'searchWait': '稍等，正在查询中！',
      'searchReinput': '请重新输入搜索词！',
      'likesNum': '收藏数：',
      'commentsNum': '评论数：',
      'commentsNew': '最新评论',
      'commentsTop': '热门评论',
      'noComments': '没有评论',
      'inputComment': '输入评论',
      'deleteComment': '删除',
      'changeComment': '更改',
      'confirm': '确认',
      'cancel': '取消',
      'noNetWork': '没有网络连接',
      'save': '保存',
      'saveCode': '请扫描二维码',
      'findpoetry': '查找诗词',
    },
  };

  String get heading {
    return _localizedValues[locale.languageCode]['heading'];
  }

  String get search {
    return _localizedValues[locale.languageCode]['search'];
  }

  String get todayPoetry {
    return _localizedValues[locale.languageCode]['todayPoetry'];
  }

  String get change {
    return _localizedValues[locale.languageCode]['change'];
  }

  String get addTime {
    return _localizedValues[locale.languageCode]['addTime'];
  }

  String get author {
    return _localizedValues[locale.languageCode]['author'];
  }

  String get dynasty {
    return _localizedValues[locale.languageCode]['dynasty'];
  }

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get content {
    return _localizedValues[locale.languageCode]['content'];
  }

  String get dismissed {
    return _localizedValues[locale.languageCode]['dismissed'];
  }

  String get copied {
    return _localizedValues[locale.languageCode]['copied'];
  }

  String get searchError {
    return _localizedValues[locale.languageCode]['searchError'];
  }

  String get searchWarning {
    return _localizedValues[locale.languageCode]['searchWarning'];
  }

  String get searchWait {
    return _localizedValues[locale.languageCode]['searchWait'];
  }

  String get searchReinput {
    return _localizedValues[locale.languageCode]['searchReinput'];
  }

  String get likesNum {
    return _localizedValues[locale.languageCode]['likesNum'];
  }

  String get commentsNum {
    return _localizedValues[locale.languageCode]['commentsNum'];
  }

  String get commentsNew {
    return _localizedValues[locale.languageCode]['commentsNew'];
  }

  String get commentsTop {
    return _localizedValues[locale.languageCode]['commentsTop'];
  }

  String get noComments {
    return _localizedValues[locale.languageCode]['noComments'];
  }

  String get inputComment {
    return _localizedValues[locale.languageCode]['inputComment'];
  }

  String get deleteComment {
    return _localizedValues[locale.languageCode]['deleteComment'];
  }

  String get changeComment {
    return _localizedValues[locale.languageCode]['changeComment'];
  }

  String get confirm {
    return _localizedValues[locale.languageCode]['confirm'];
  }

  String get cancel {
    return _localizedValues[locale.languageCode]['cancel'];
  }

  String get noNetWork {
    return _localizedValues[locale.languageCode]['noNetWork'];
  }

  String get save {
    return _localizedValues[locale.languageCode]['save'];
  }

  String get saveCode {
    return _localizedValues[locale.languageCode]['saveCode'];
  }

  String get findPoetry {
    return _localizedValues[locale.languageCode]['findPoetry'];
  }
}

class VersesLocalizationsDelegate extends LocalizationsDelegate<VersesLocalizations> {
  const VersesLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['zh', 'en'].contains(locale.languageCode);

  @override
  Future<VersesLocalizations> load(Locale locale) {
    return new SynchronousFuture<VersesLocalizations>(new VersesLocalizations(locale));
  }

  @override
  bool shouldReload(VersesLocalizationsDelegate old) => false;
}

class ThemeProvide extends ChangeNotifier {
  int _themeIndex = 0;

  ThemeProvide(int theme) {
    _themeIndex = theme;
  }

  int get value => _themeIndex;

  void setTheme(int index) async {
    _themeIndex = index;
    notifyListeners();
  }
}
