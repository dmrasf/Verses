import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPoetry extends StatelessWidget {
  final TextEditingController myControllerAuthor;
  final TextEditingController myControllerDynasity;
  final TextEditingController myControllerTitle;
  final TextEditingController myControllerContent;

  const SearchPoetry({
    Key key,
    this.myControllerAuthor,
    this.myControllerDynasity,
    this.myControllerTitle,
    this.myControllerContent,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldContainer(
          child: TextField(
            controller: myControllerAuthor,
            decoration: InputDecoration(
              hintText: "作者",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: myControllerDynasity,
            decoration: InputDecoration(
              hintText: "朝代",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: myControllerTitle,
            decoration: InputDecoration(
              hintText: "题目",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        TextFieldContainer(
          child: TextField(
            controller: myControllerContent,
            decoration: InputDecoration(
              hintText: "内容",
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: this.child,
    );
  }
}
