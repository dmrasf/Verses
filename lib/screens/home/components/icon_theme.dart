import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconChangeTheme extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IconChangeTheme();
  }
}

class _IconChangeTheme extends State<IconChangeTheme> {
  bool isDark = false;

  void changeTheme() {
    setState(() {
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
          isDark ? "assets/icons/moon.svg" : "assets/icons/sun.svg",
          height: 20,
          width: 20,
          color: Colors.black,
        ));
  }
}
