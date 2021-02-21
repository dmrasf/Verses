import 'package:Verses/components/poetry_list_and_item.dart';
import 'package:Verses/screens/home/components/poetry_item_show_col.dart';
import 'package:flutter/material.dart';

enum PairTypes { addtime, author, dynasty }

class CollectionListView extends StatefulWidget {
  final List<Map<String, dynamic>> poetries;

  CollectionListView({Key key, this.poetries}) : super(key: key);

  @override
  _CollectionListViewState createState() => _CollectionListViewState(poetries: this.poetries);
}

class _CollectionListViewState extends State<CollectionListView> {
  final List<Map<String, dynamic>> poetries;
  var pairType = PairTypes.addtime;

  _CollectionListViewState({this.poetries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: getCollectionView(),
    );
  }

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

  AppBar buildAppBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            this.pairType = PairTypes.addtime;
            setState(() {});
          },
          icon: Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {
            this.pairType = PairTypes.author;
            setState(() {});
          },
          icon: Icon(Icons.wc),
        ),
        IconButton(
          onPressed: () {
            this.pairType = PairTypes.dynasty;
            setState(() {});
          },
          icon: Icon(Icons.atm),
        )
      ],
    );
  }

  Widget getCollectionView() {
    switch (this.pairType) {
      case PairTypes.author:
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          children: <Widget>[
            Icon(Icons.ac_unit, color: Colors.red),
            Icon(Icons.airport_shuttle, color: Colors.red),
            Icon(Icons.all_inclusive, color: Colors.red),
            Icon(Icons.beach_access, color: Colors.red),
            Icon(Icons.cake, color: Colors.red),
            Icon(Icons.free_breakfast, color: Colors.red)
          ],
        );
      case PairTypes.dynasty:
        return Container();
      default:
        return CollectionPoetryListView(
          poetries: poetries,
          poetryItem: (poetry) => PoetryItemShowForCol(poetry: poetry),
        );
    }
  }
}
