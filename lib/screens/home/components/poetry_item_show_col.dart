import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/components/poetry_item_show_card.dart';
import 'package:Verses/screens/home/components/home_collection_poetry_show_buttons.dart';

class PoetryItemShowForCol extends StatelessWidget {
  final Map<String, dynamic> poetry;

  PoetryItemShowForCol({Key key, this.poetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              this.poetry['题目'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: PoetryItemShowCard(poetry: this.poetry, themeId: themeId),
              ),
              CollectionPoetryShowButtons(poetry: this.poetry, themeId: themeId),
            ],
          ),
          backgroundColor: themeColor[themeId]['backgroundColor'],
        );
      },
    );
  }
}
