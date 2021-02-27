import 'package:Verses/utils.dart';
import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDark = await SharedPreferencesUtil.getData<bool>('theme') ?? false;
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final SystemUiOverlayStyle statusBarStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  MyApp({Key key, this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(statusBarStyle);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvide(isDark ? 1 : 0)),
      ],
      child: Consumer<ThemeProvide>(
        builder: (context, themeProvider, child) {
          var themeId = themeProvider.value;
          return MaterialApp(
            title: 'Verses',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              const VersesLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('zh', 'CN'),
              const Locale('en', 'US'),
            ],
            theme: ThemeData(
              scaffoldBackgroundColor: themeColor[themeId]['backgroundColor'],
              primaryColor: themeColor[themeId]['primaryColor'],
              textTheme:
                  Theme.of(context).textTheme.apply(bodyColor: themeColor[themeId]['textColor']),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
