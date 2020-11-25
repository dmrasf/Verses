import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/search/components/text_and_drop_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Column(
      children: [
        TextFieldContainer(
          child: TextField(
            controller: myControllerAuthor,
            focusNode: myFocusNodeAuthor,
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            decoration: getInputDec(VersesLocalizations.of(context).author, myControllerAuthor),
          ),
        ),
        DropContainer(setDynasty: setDynasty),
        TextFieldContainer(
          child: TextField(
            controller: myControllerTitle,
            focusNode: myFocusNodeTitle,
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            decoration: getInputDec(VersesLocalizations.of(context).title, myControllerTitle),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: myControllerContent,
            focusNode: myFocusNodeContent,
            style: TextStyle(textBaseline: TextBaseline.alphabetic),
            decoration: getInputDec(VersesLocalizations.of(context).content, myControllerContent),
          ),
        ),
      ],
    );
  }

  // 修饰搜索框
  InputDecoration getInputDec(String hintStr, TextEditingController controller) {
    return InputDecoration(
      hintText: hintStr,
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      suffixIcon: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => controller.clear(),
        icon: SvgPicture.asset("assets/icons/clear.svg", height: 10, width: 10, color: Colors.grey),
      ),
    );
  }
}
