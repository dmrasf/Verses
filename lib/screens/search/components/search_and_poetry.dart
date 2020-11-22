import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/search/components/text_and_drop_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPoetry extends StatelessWidget {
  final TextEditingController myControllerAuthor;
  final TextEditingController myControllerDynasty;
  final TextEditingController myControllerTitle;
  final TextEditingController myControllerContent;
  final FocusNode myFocusNodeAuthor;
  final FocusNode myFocusNodeDynasty;
  final FocusNode myFocusNodeTitle;
  final FocusNode myFocusNodeContent;

  const SearchPoetry({
    Key key,
    this.myControllerAuthor,
    this.myControllerDynasty,
    this.myControllerTitle,
    this.myControllerContent,
    this.myFocusNodeAuthor,
    this.myFocusNodeDynasty,
    this.myFocusNodeTitle,
    this.myFocusNodeContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldContainer(
          child: TextField(
            controller: myControllerAuthor,
            focusNode: myFocusNodeAuthor,
            decoration: getInputDec(VersesLocalizations.of(context).author),
          ),
        ),
        DropContainer(),
        TextFieldContainer(
          child: TextField(
            controller: myControllerDynasty,
            focusNode: myFocusNodeDynasty,
            decoration: getInputDec(VersesLocalizations.of(context).dynasty),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: myControllerTitle,
            focusNode: myFocusNodeTitle,
            decoration: getInputDec(VersesLocalizations.of(context).title),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: myControllerContent,
            focusNode: myFocusNodeContent,
            decoration: getInputDec(VersesLocalizations.of(context).content),
          ),
        ),
      ],
    );
  }

  // 修饰搜索框
  InputDecoration getInputDec(String hintStr) {
    return InputDecoration(
      hintText: hintStr,
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }
}
