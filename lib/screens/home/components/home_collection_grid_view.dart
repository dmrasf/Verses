import 'package:flutter/material.dart';
import 'package:Verses/screens/home/components/poetry_item_show_col.dart';
import 'package:Verses/components/poetry_list_and_item.dart';
import 'package:provider/provider.dart';
import 'package:Verses/contants.dart';

class CollectionGridView extends StatefulWidget {
  final String pairType;
  final Function updatePoetriesForParent;
  List<Map<String, dynamic>> poetries;

  CollectionGridView({Key key, this.pairType, this.poetries, this.updatePoetriesForParent})
      : super(key: key);

  @override
  _CollectionGridViewState createState() => _CollectionGridViewState();
}

class _CollectionGridViewState extends State<CollectionGridView> {
  @override
  Widget build(BuildContext context) {
    List<List<Map<String, dynamic>>> pairPoetries = getPoetriesInPairs(widget.pairType);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
      ),
      itemCount: pairPoetries.length,
      itemBuilder: (context, index) {
        return CollectionGridItemView(
          pairTypeKey: pairPoetries[index][0][widget.pairType],
          poetries: pairPoetries[index],
          updatePoetriesForParent: this.updatePoetries,
        );
      },
    );
  }

  void updatePoetries(Map<String, dynamic> poetry) {
    widget.updatePoetriesForParent(poetry);
    widget.poetries.remove(poetry);
    setState(() {});
  }

  List<List<Map<String, dynamic>>> getPoetriesInPairs(String key) {
    var pairP = Map<String, List<Map<String, dynamic>>>();
    for (var i = 0; i < widget.poetries.length; i++) {
      if (pairP.containsKey(widget.poetries[i][key])) {
        pairP[widget.poetries[i][key]].add(widget.poetries[i]);
      } else {
        pairP[widget.poetries[i][key]] = List<Map<String, dynamic>>();
        pairP[widget.poetries[i][key]].add(widget.poetries[i]);
      }
    }
    var pairPoetries = List<List<Map<String, dynamic>>>();
    pairP.forEach((_, pl) {
      pairPoetries.add(pl);
    });
    return pairPoetries;
  }
}

class CollectionGridItemView extends StatelessWidget {
  final String pairTypeKey;
  final List<Map<String, dynamic>> poetries;
  final Function updatePoetriesForParent;

  CollectionGridItemView({Key key, this.pairTypeKey, this.poetries, this.updatePoetriesForParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return GestureDetector(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              this.pairTypeKey,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: themeColor[themeId]['textColor'],
              ),
            ),
            decoration: BoxDecoration(
              color: themeColor[themeId]['primaryColor'],
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(),
                  body: CollectionPoetryListView(
                    poetries: this.poetries,
                    poetryItem: (poetry) => PoetryItemShowForCol(poetry: poetry),
                    updatePoetriesForParent: this.updatePoetriesForParent,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
