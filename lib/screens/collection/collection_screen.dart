import 'package:Verses/screens/collection/components/grid_view.dart';
import 'package:Verses/screens/collection/components/list_view.dart';
import 'package:Verses/screens/collection/components/poetry_item_show.dart';
import 'package:Verses/components/float_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Verses/utils.dart';
import 'package:Verses/contants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Verses/screens/collection/components/collection_view.dart';

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
          body: GestureDetector(
            child: getCollectionView(themeId),
            onHorizontalDragEnd: (DragEndDetails details) {
              String next, last;
              if (this.pairType == PairTypes['addtime'] || this.pairType == PairTypes['addtimeN']) {
                next = 'author';
                last = 'dynasty';
              } else if (this.pairType == PairTypes['author']) {
                next = 'dynasty';
                last = 'addtime';
              } else {
                next = 'addtime';
                last = 'author';
              }
              if (details.primaryVelocity > 5) {
                _updatePairType(PairTypes[last]);
              } else if (details.primaryVelocity < -5) {
                _updatePairType(PairTypes[next]);
              }
            },
          ),
          floatingActionButton: FloatButton(
              Icon(
                Icons.add,
                color: themeColor[themeId]['backgroundColor'],
              ), () async {
            await [Permission.camera].request();
            var status = await Permission.camera.status;
            if (status.isUndetermined) {
              openAppSettings();
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CollectionQrView(),
                ),
              );
            }
          }, themeId),
        );
      },
    );
  }

  Widget buildButton(String pt, int themeId) {
    String title;
    switch (pt) {
      case 'addtime':
        title = VersesLocalizations.of(context).addTime;
        break;
      case 'author':
        title = VersesLocalizations.of(context).author;
        break;
      case 'dynasty':
        title = VersesLocalizations.of(context).dynasty;
        break;
    }

    return FlatButton(
      child: Text(
        title,
        style: TextStyle(
          color: themeColor[themeId]["textColor"],
          fontSize: this.pairType == PairTypes[pt] ? 15 : 10,
        ),
      ),
      onPressed: () {
        _updatePairType(PairTypes[pt]);
      },
    );
  }

  AppBar _buildAppBar(var themeId) {
    return AppBar(
      actions: [
        buildButton('addtime', themeId),
        buildButton('author', themeId),
        buildButton('dynasty', themeId),
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
