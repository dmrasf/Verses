import 'package:verses/utils.dart';
import 'package:flutter/material.dart';
import 'package:verses/contants.dart';
import 'package:verses/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDark = await SharedPreferencesUtil.getData<bool>('theme') ?? false;
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvide(isDark ? 1 : 0),
        ),
      ],
      child: Consumer<ThemeProvide>(
        builder: (context, themeProvider, child) {
          var themeId = themeProvider.value;
          return MaterialApp(
            title: 'verses',
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
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(bodyColor: themeColor[themeId]['textColor']),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
