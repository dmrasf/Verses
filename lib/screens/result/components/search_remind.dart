import 'package:flutter/material.dart';

class SearchRemind extends StatelessWidget {
  final String reminds;

  SearchRemind({Key key, this.reminds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(this.reminds),
    );
  }
}
