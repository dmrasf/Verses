import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';

class PoetryItemShowForCol extends StatelessWidget {
  final Map<String, dynamic> poetry;

  PoetryItemShowForCol({Key key, this.poetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: getContent(this.poetry),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
