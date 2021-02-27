import 'package:flutter/material.dart';
import 'package:Verses/screens/collection/components/poetry_item_show.dart';
import 'package:Verses/screens/collection/components/list_view.dart';
import 'package:provider/provider.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/utils.dart';

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
        Size size = MediaQuery.of(context).size;
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
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: false,
              isDismissible: true,
              backgroundColor: themeColor[themeId]['primaryColor'],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              builder: (context) {
                return Container(
                  width: size.width,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.red),
                      overlayColor: MaterialStateProperty.all(themeColor[themeId]['primaryColor']),
                    ),
                    child: Text('删除'),
                    onPressed: () {
                      for (var poetry in poetries) {
                        this.updatePoetriesForParent(poetry);
                        collectionToggle(poetry);
                      }
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
