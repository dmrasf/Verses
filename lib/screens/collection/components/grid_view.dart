import 'package:flutter/material.dart';
import 'package:verses/screens/collection/components/grid_view_item.dart';

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
