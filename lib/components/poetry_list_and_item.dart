import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:provider/provider.dart';
import 'package:Verses/utils.dart';

class PoetryListView extends StatelessWidget {
  final List<Map<String, dynamic>> poetries;
  final Function poetryItem;

  PoetryListView({Key key, this.poetries, this.poetryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: this.poetries.length,
        itemBuilder: (context, index) {
          return PoetryListItem(
            poetry: this.poetries[index],
            poetryItem: this.poetryItem,
          );
        },
      ),
    );
  }
}

class CollectionPoetryListView extends StatelessWidget {
  final List<Map<String, dynamic>> poetries;
  final Function poetryItem;
  final Function updatePoetriesForParent;

  CollectionPoetryListView({Key key, this.poetries, this.poetryItem, this.updatePoetriesForParent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: this.poetries.length,
        itemBuilder: (context, index) {
          return Consumer<ThemeProvide>(
            builder: (context, themeProvider, child) {
              var themeId = themeProvider.value;
              return Dismissible(
                key: Key(this.poetries[index]['内容']),
                child: PoetryListItem(
                  poetry: this.poetries[index],
                  poetryItem: this.poetryItem,
                ),
                onDismissed: (direction) {
                  collectionToggle(this.poetries[index]);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '《' +
                            this.poetries[index]['题目'] +
                            '》 ' +
                            VersesLocalizations.of(context).dismissed,
                        style: TextStyle(color: themeColor[themeId]['textColor']),
                      ),
                      duration: Duration(milliseconds: 500),
                      backgroundColor: themeColor[themeId]['primaryColor'],
                    ),
                  );
                  updatePoetriesForParent(this.poetries[index]);
                },
                direction: DismissDirection.endToStart,
              );
            },
          );
        },
      ),
    );
  }
}

class PoetryListItem extends StatelessWidget {
  final Map<String, dynamic> poetry;
  final Function poetryItem;

  PoetryListItem({Key key, this.poetry, this.poetryItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return GestureDetector(
          child: Container(
            height: size.height * 0.1,
            margin: EdgeInsets.only(top: 6, left: 4, right: 4),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.6,
                  child: Text(this.poetry['题目'],
                      maxLines: 1,
                      style: TextStyle(color: themeColor[themeId]['textColor']),
                      overflow: TextOverflow.ellipsis),
                ),
                Spacer(),
                Text(
                  this.poetry['作者'],
                  style: TextStyle(color: themeColor[themeId]['textColor']),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: themeColor[themeId]['primaryColor'],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => poetryItem(this.poetry)),
            );
          },
        );
      },
    );
  }
}
