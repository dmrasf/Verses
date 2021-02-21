import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

const kPirmaryColor = Colors.red;
const kTextColor = Colors.blue;
const kBackgroundColor = Colors.pink;

const double kDefaultPadding = 20.0;

const String urlPoetry = 'https://dmrasf.com:7777/poetry/';

const Map themeColor = {
  0: {
    //white
    'primaryColor': Color(0xffffffff),
    'backgroundColor': Color(0xfff3f3f3),
    'buttonColor': Colors.black,
    'textColor': Colors.black,
    'buttonSvg': 'assets/icons/moon.svg',
  },
  1: {
    //black
    'primaryColor': Color(0xff2a2a2a),
    'backgroundColor': Color(0xff000000),
    'buttonColor': Colors.white,
    'textColor': Colors.white,
    'buttonSvg': 'assets/icons/sun.svg',
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
      'author': 'Author',
      'dynasty': 'Dynasty',
      'title': 'Title(Separate multiple search terms with a space)',
      'content': 'Content(Separate multiple search terms with a space)',
      'searchError': '数据库启动失败！',
      'searchWarning': '根据关键词无法找到相关诗词！',
      'searchWait': '稍等，正在查询中！',
      'searchReinput': '请重新输入搜索词！',
    },
    'zh': {
      'heading': '诗词搜索',
      'search': '搜索',
      'todayPoetry': '今日诗词',
      'change': '下一首',
      'author': '作者',
      'dynasty': '朝代',
      'title': '题目(多个搜索词请用空格分开)',
      'content': '内容(多个搜索词请用空格分开)',
      'searchError': '数据库启动失败！',
      'searchWarning': '根据关键词无法找到相关诗词！',
      'searchWait': '稍等，正在查询中！',
      'searchReinput': '请重新输入搜索词！',
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
