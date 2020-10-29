import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SearchPoetry(),
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: kPirmaryColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPoetry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldContainer(
          child: TextField(
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
