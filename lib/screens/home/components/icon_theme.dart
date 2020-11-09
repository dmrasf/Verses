import 'package:Verses/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class IconChangeTheme extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IconChangeTheme();
  }
}

class _IconChangeTheme extends State<IconChangeTheme> {
  bool isDark = false;

  void changeTheme() {
    setState(() {
      Provider.of<ThemeProvide>(context, listen: false).setTheme(isDark ? 0 : 1);
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 8,
      // 切换主题
      onPressed: changeTheme,
      icon: SvgPicture.asset(
        isDark ? "assets/icons/sun.svg" : "assets/icons/moon.svg",
        height: 20,
        width: 20,
        color: isDark ? Colors.white : Colors.black,
      ),
    );
  }
}
