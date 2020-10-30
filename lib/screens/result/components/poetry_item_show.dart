import 'package:flutter/material.dart';

class PoetryItemShow extends StatelessWidget {
  final Map<String, dynamic> poetry;

  PoetryItemShow({Key key, this.poetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          this.poetry['内容'],
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
