import 'package:flutter/material.dart';
import 'package:verses/contants.dart';
import 'package:verses/screens/search/components/text_and_drop_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchPoetry extends StatelessWidget {
  final TextEditingController myControllerAuthor;
  final TextEditingController myControllerTitle;
  final TextEditingController myControllerContent;
  final FocusNode myFocusNodeAuthor;
  final FocusNode myFocusNodeTitle;
  final FocusNode myFocusNodeContent;

  final Function setDynasty;

  const SearchPoetry({
    Key key,
    this.myControllerAuthor,
    this.myControllerTitle,
    this.myControllerContent,
    this.myFocusNodeAuthor,
    this.myFocusNodeTitle,
    this.myFocusNodeContent,
    this.setDynasty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Column(
          children: [
            TextFieldContainer(
              child: TextField(
                  controller: myControllerAuthor,
                  focusNode: myFocusNodeAuthor,
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                  decoration: getInputDec(
                      VersesLocalizations.of(context).author, myControllerAuthor, themeId)),
            ),
            DropContainer(setDynasty: setDynasty, themeId: themeId),
            TextFieldContainer(
              child: TextField(
                  controller: myControllerTitle,
                  focusNode: myFocusNodeTitle,
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                  decoration: getInputDec(
                      VersesLocalizations.of(context).title, myControllerTitle, themeId)),
            ),
            TextFieldContainer(
              child: TextField(
                  controller: myControllerContent,
                  focusNode: myFocusNodeContent,
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                  decoration: getInputDec(
                      VersesLocalizations.of(context).content, myControllerContent, themeId)),
            ),
          ],
        );
      },
    );
  }

  // 修饰搜索框
  InputDecoration getInputDec(String hintStr, TextEditingController controller, int themeId) {
    return InputDecoration(
      hintText: hintStr,
      hintStyle: TextStyle(
        color: themeColor[themeId]['textColor'].withOpacity(0.4),
        fontSize: 13,
      ),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      suffixIcon: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => controller.clear(),
        icon: SvgPicture.asset("assets/icons/clear.svg",
            height: 10, width: 10, color: themeColor[themeId]['textColor'].withOpacity(0.4)),
      ),
    );
  }
}
