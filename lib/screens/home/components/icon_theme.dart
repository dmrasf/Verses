import 'package:verses/contants.dart';
import 'package:verses/utils.dart';
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
  void _changeTheme() async {
    bool isDark = await SharedPreferencesUtil.getData<bool>('theme') ?? false;
    setState(() {
      Provider.of<ThemeProvide>(context, listen: false).setTheme(isDark ? 0 : 1);
    });
    isDark = !isDark;
    await SharedPreferencesUtil.setData<bool>('theme', isDark);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return IconButton(
          iconSize: 8,
          onPressed: _changeTheme,
          icon: SvgPicture.asset(
            themeColor[themeId]['buttonSvg'],
            height: 20,
            width: 20,
            color: themeColor[themeId]['buttonColor'],
          ),
        );
      },
    );
  }
}
