import 'package:Verses/screens/collection/components/grid_view.dart';
import 'package:Verses/screens/collection/components/list_view.dart';
import 'package:Verses/screens/collection/components/poetry_item_show.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Verses/utils.dart';
import 'package:Verses/contants.dart';

class CollectionListView extends StatefulWidget {
  final List<Map<String, dynamic>> poetries;
  CollectionListView({Key key, this.poetries}) : super(key: key);
  @override
  _CollectionListViewState createState() => _CollectionListViewState();
}

class _CollectionListViewState extends State<CollectionListView> {
  var pairType;

  void _getPairType() async {
    this.pairType = await SharedPreferencesUtil.getData<int>('pairType') ?? PairTypes['addtime'];
    setState(() {});
  }

  void _updatePairType(int pt) async {
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
    _getPairType();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Scaffold(
          appBar: _buildAppBar(themeId),
          body: getCollectionView(themeId),
        );
      },
    );
  }

  AppBar _buildAppBar(var themeId) {
    return AppBar(
      actions: [
        FlatButton(
          child: Text(
            VersesLocalizations.of(context).addTime,
            style: TextStyle(color: themeColor[themeId]["textColor"]),
          ),
          onPressed: () {
            _updatePairType(PairTypes['addtime']);
          },
        ),
        FlatButton(
          child: Text(
            VersesLocalizations.of(context).author,
            style: TextStyle(color: themeColor[themeId]["textColor"]),
          ),
          onPressed: () {
            _updatePairType(PairTypes['author']);
          },
        ),
        FlatButton(
          child: Text(
            VersesLocalizations.of(context).dynasty,
            style: TextStyle(color: themeColor[themeId]["textColor"]),
          ),
          onPressed: () {
            _updatePairType(PairTypes['dynasty']);
          },
        ),
      ],
    );
  }

  void updatePoetries(Map<String, dynamic> poetry) {
    widget.poetries.remove(poetry);
    setState(() {});
  }

  Widget getCollectionView(var themeId) {
    if (widget.poetries.length == 0) {
      return Center(child: Image(image: AssetImage('assets/imgs/empty.png')));
    }
    if (this.pairType == PairTypes['author']) {
      return CollectionGridView(
        pairType: '作者',
        poetries: widget.poetries,
        updatePoetriesForParent: this.updatePoetries,
      );
    } else if (this.pairType == PairTypes['dynasty']) {
      return CollectionGridView(
        pairType: '朝代',
        poetries: widget.poetries,
        updatePoetriesForParent: this.updatePoetries,
      );
    } else {
      var tmpPoetries = widget.poetries;
      if (this.pairType == PairTypes['addtimeN']) {
        tmpPoetries = widget.poetries.reversed.toList();
      }
      return CollectionPoetryListView(
        poetries: tmpPoetries,
        poetryItem: (poetry) => PoetryItemShowForCol(poetry: poetry),
        updatePoetriesForParent: this.updatePoetries,
      );
    }
  }
}
