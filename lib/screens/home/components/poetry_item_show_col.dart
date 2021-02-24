import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/components/poetry_item_show_card.dart';

class PoetryItemShowForCol extends StatelessWidget {
  final Map<String, dynamic> poetry;

  PoetryItemShowForCol({Key key, this.poetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        Size size = MediaQuery.of(context).size;
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
              Container(
                height: size.height * 0.1,
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.music_note),
                        color: themeColor[themeId]['textColor'],
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.comment),
                        color: themeColor[themeId]['textColor'],
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.feedback),
                        color: themeColor[themeId]['textColor'],
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.share),
                        color: themeColor[themeId]['textColor'],
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: themeColor[themeId]['backgroundColor'],
        );
      },
    );
  }
}
