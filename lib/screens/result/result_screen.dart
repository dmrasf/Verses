import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/search/components/search_and_poetry.dart';

class ResultScreen extends StatelessWidget {
  final String authorString;
  final String dynasityString;
  final String titleString;
  final String contentString;

  const ResultScreen({
    Key key,
    this.authorString,
    this.dynasityString,
    this.titleString,
    this.contentString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(this.authorString),
            Text(this.dynasityString),
            Text(this.titleString),
            Text(this.contentString),
          ],
        ),
      ),
    );
  }
}
