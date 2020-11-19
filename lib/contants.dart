import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

const kPirmaryColor = Color(0xFFCC9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);

const double kDefaultPadding = 20.0;

const String urlPoetry = "https://dmrasf.com:7777/poetry/";

const Map themeColor = {
  0: {
    //grey
    "primaryColor": Color(0xff9E9E9E),
    "textColor": Color(0xFF3C4046),
    "backgroundColor": Color(0xFFF9F8FD),
  },
  1: {
    //black
    "primaryColor": Color(0xff333333),
    "textColor": Color(0xFF3C4046),
    "backgroundColor": Color(0xFFF9F8FD),
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
      'change': 'Change',
      'author': 'Author',
      'dynasty': 'Dynasty',
      'title': 'Title',
      'content': 'Content',
    },
    'zh': {
      'heading': '诗词搜索',
      'search': '搜索',
      'todayPoetry': '今日诗词',
      'change': '下一首',
      'author': '作者',
      'dynasty': '朝代',
      'title': '题目',
      'content': '内容',
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
