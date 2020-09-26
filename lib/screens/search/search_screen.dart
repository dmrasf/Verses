import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Search"),
            TextField(
              decoration: InputDecoration(
                hintText: "作者",
                hintStyle: TextStyle(
                  color: kPirmaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "朝代",
                hintStyle: TextStyle(
                  color: kPirmaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "题目",
                hintStyle: TextStyle(
                  color: kPirmaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "内容（用空格分开）",
                hintStyle: TextStyle(
                  color: kPirmaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
