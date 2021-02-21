import 'package:Verses/components/poetry_list_and_item.dart';
import 'package:Verses/screens/home/components/poetry_item_show_col.dart';
import 'package:flutter/material.dart';

class CollectionListView extends StatelessWidget {
  final List<Map<String, dynamic>> poetries;

  CollectionListView({Key key, this.poetries}) : super(key: key);

  Map<String, List<Map<String, dynamic>>> getPoetriesInPairs(String key) {
    var pairP = Map<String, List<Map<String, dynamic>>>();
    for (var i = 0; i < this.poetries.length; i++) {
      if (pairP.containsKey(poetries[i][key])) {
        pairP[poetries[i][key]].add(this.poetries[i]);
      } else {
        pairP[poetries[i][key]] = List<Map<String, dynamic>>();
        pairP[poetries[i][key]].add(this.poetries[i]);
      }
    }
    return pairP;
  }

  @override
  Widget build(BuildContext context) {
    print(getPoetriesInPairs('作者'));
    return Scaffold(
      body: PoetryListView(
        poetries: poetries,
        poetryItem: (poetry) => PoetryItemShowForCol(poetry: poetry),
      ),
    );
  }
}
