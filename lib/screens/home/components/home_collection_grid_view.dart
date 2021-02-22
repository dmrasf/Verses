import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Verses/utils.dart';
import 'package:Verses/contants.dart';

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
        return Text(widget.pairPoetries[index][0][widget.pairType]);
      },
    );
  }
}

class CollectionGridItemView extends StatelessWidget {
  CollectionGridItemView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
