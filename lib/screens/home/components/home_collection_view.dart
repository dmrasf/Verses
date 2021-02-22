import 'package:Verses/components/poetry_list_and_item.dart';
import 'package:Verses/screens/home/components/poetry_item_show_col.dart';
import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';

const Map PairTypes = {'addtime': 1, 'author': 2, 'dynasty': 3};

class CollectionListView extends StatefulWidget {
  final List<Map<String, dynamic>> poetries;

  CollectionListView({Key key, this.poetries}) : super(key: key);

  @override
  _CollectionListViewState createState() => _CollectionListViewState(poetries: this.poetries);
}

class _CollectionListViewState extends State<CollectionListView> {
  final List<Map<String, dynamic>> poetries;
  var pairType;

  _CollectionListViewState({this.poetries});

  void getPairType() async {
    this.pairType = await SharedPreferencesUtil.getData<int>('pairType') ?? PairTypes['addtime'];
    setState(() {});
  }

  void updatePairType(int pt) async {
    this.pairType = pt;
    await SharedPreferencesUtil.setData<int>('pairType', this.pairType);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPairType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: getCollectionView());
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
            updatePairType(PairTypes['addtime']);
          },
          icon: Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {
            updatePairType(PairTypes['author']);
          },
          icon: Icon(Icons.wc),
        ),
        IconButton(
          onPressed: () {
            updatePairType(PairTypes['dynasty']);
          },
          icon: Icon(Icons.atm),
        )
      ],
    );
  }

  Widget getCollectionView() {
    if (this.pairType == PairTypes['author']) {
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
    } else if (this.pairType == PairTypes['dynasty']) {
      return Container();
    } else {
      return CollectionPoetryListView(
        poetries: poetries,
        poetryItem: (poetry) => PoetryItemShowForCol(poetry: poetry),
      );
    }
  }
}
