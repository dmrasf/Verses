import 'package:Verses/components/poetry_list_and_item.dart';
import 'package:Verses/screens/home/components/poetry_card.dart';
import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:provider/provider.dart';
import 'package:Verses/utils.dart';

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
                  (keyForCard.currentState as PoetryCardState)
                      .updatePoetryCol(this.poetries[index]);
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
