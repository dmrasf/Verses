import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvide()),
      ],
      child: Consumer<ThemeProvide>(
        builder: (context, themeProvider, child) {
          var themeId = themeProvider._themeIndex;
          return MaterialApp(
            title: 'Verses',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              const VersesLocalizationsDelegate(),
              // 本地化字符串
              GlobalMaterialLocalizations.delegate,
              // widget 文本默认方向
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('zh', 'CN'),
              const Locale('en', 'US'),
            ],
            theme: ThemeData(
              scaffoldBackgroundColor: themeColor[themeId]["backgroundColor"],
              primaryColor: themeColor[themeId]["primaryColor"],
              textTheme:
                  Theme.of(context).textTheme.apply(bodyColor: themeColor[themeId]["textColor"]),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

class ThemeProvide extends ChangeNotifier {
  int _themeIndex = 0;

  int get value => _themeIndex;

  void setTheme(int index) async {
    _themeIndex = index;
    notifyListeners();
  }
}
