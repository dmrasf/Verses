import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verses/contants.dart';
import 'package:verses/components/poetry_item_show_card.dart';
import 'package:verses/screens/result/components/search_poetry_show_like_button.dart';

class PoetryItemShow extends StatelessWidget {
  final Map<String, dynamic> poetry;

  PoetryItemShow({Key key, this.poetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: PoetryItemShowCard(poetry: this.poetry, themeId: themeId),
              ),
              SearchPoetryShowLikeButton(poetry: this.poetry, themeId: themeId),
            ],
          ),
          backgroundColor: themeColor[themeId]['backgroundColor'],
        );
      },
    );
  }
}
