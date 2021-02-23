import 'package:Verses/components/poetry_list_and_item.dart';
import 'package:Verses/screens/home/components/poetry_item_show_col.dart';
import 'package:Verses/screens/home/components/home_collection_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Verses/utils.dart';
import 'package:Verses/contants.dart';

const Map PairTypes = {'addtime': 1, 'addtimeN': 2, 'author': 3, 'dynasty': 4};

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
    if (pt == PairTypes['addtime']) {
      if (this.pairType == PairTypes['addtime']) {
        this.pairType = PairTypes['addtimeN'];
        await SharedPreferencesUtil.setData<int>('pairType', PairTypes['addtimeN']);
      } else if (this.pairType == PairTypes['addtimeN']) {
        this.pairType = PairTypes['addtime'];
        await SharedPreferencesUtil.setData<int>('pairType', PairTypes['addtime']);
      } else {
        this.pairType = pt;
        await SharedPreferencesUtil.setData<int>('pairType', this.pairType);
      }
    } else {
      this.pairType = pt;
      await SharedPreferencesUtil.setData<int>('pairType', this.pairType);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPairType();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Scaffold(appBar: buildAppBar(themeId), body: getCollectionView(themeId));
      },
    );
  }

  AppBar buildAppBar(var themeId) {
    return AppBar(
      actions: [
        FlatButton(
          child: Text(
            VersesLocalizations.of(context).addTime,
            style: TextStyle(color: themeColor[themeId]["textColor"]),
          ),
          onPressed: () {
            updatePairType(PairTypes['addtime']);
          },
        ),
        FlatButton(
          child: Text(
            VersesLocalizations.of(context).author,
            style: TextStyle(color: themeColor[themeId]["textColor"]),
          ),
          onPressed: () {
            updatePairType(PairTypes['author']);
          },
        ),
        FlatButton(
          child: Text(
            VersesLocalizations.of(context).dynasty,
            style: TextStyle(color: themeColor[themeId]["textColor"]),
          ),
          onPressed: () {
            updatePairType(PairTypes['dynasty']);
          },
        ),
      ],
    );
  }

  Widget getCollectionView(var themeId) {
    if (poetries.length == 0) {
      return Center(child: Image(image: AssetImage('assets/imgs/empty.png')));
    }
    if (this.pairType == PairTypes['author']) {
      return CollectionGridView(pairType: '作者', poetries: this.poetries);
    } else if (this.pairType == PairTypes['dynasty']) {
      return CollectionGridView(pairType: '朝代', poetries: this.poetries);
    } else {
      var tmpPoetries = poetries;
      if (this.pairType == PairTypes['addtimeN']) {
        tmpPoetries = this.poetries.reversed.toList();
      }
      return CollectionPoetryListView(
        poetries: tmpPoetries,
        poetryItem: (poetry) => PoetryItemShowForCol(poetry: poetry),
      );
    }
  }
}
