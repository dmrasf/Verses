import 'package:flutter/material.dart';
import 'package:Verses/screens/home/components/poetry_item_show_col.dart';
import 'package:Verses/components/poetry_list_and_item.dart';

class CollectionGridView extends StatefulWidget {
  final String pairType;
  final List<List<Map<String, dynamic>>> pairPoetries;

  CollectionGridView({Key key, this.pairType, this.pairPoetries}) : super(key: key);

  @override
  _CollectionGridViewState createState() => _CollectionGridViewState();
}

class _CollectionGridViewState extends State<CollectionGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemCount: widget.pairPoetries.length,
      itemBuilder: (context, index) {
        return CollectionGridItemView(
          pairTypeKey: widget.pairPoetries[index][0][widget.pairType],
          poetries: widget.pairPoetries[index],
        );
      },
    );
  }
}

class CollectionGridItemView extends StatelessWidget {
  final String pairTypeKey;
  final List<Map<String, dynamic>> poetries;

  CollectionGridItemView({Key key, this.pairTypeKey, this.poetries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Text(this.pairTypeKey),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
