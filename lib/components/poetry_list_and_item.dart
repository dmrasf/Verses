import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:provider/provider.dart';

class PoetryListItem extends StatelessWidget {
  final Map<String, dynamic> poetry;
  final Function poetryItem;

  PoetryListItem({Key key, this.poetry, this.poetryItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return GestureDetector(
          child: Container(
            height: size.height * 0.1,
            margin: EdgeInsets.only(top: 6, left: 4, right: 4),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.6,
                  child: Text(this.poetry['题目'],
                      maxLines: 1,
                      style: TextStyle(color: themeColor[themeId]['textColor']),
                      overflow: TextOverflow.ellipsis),
                ),
                Spacer(),
                Text(
                  this.poetry['作者'],
                  style: TextStyle(color: themeColor[themeId]['textColor']),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: themeColor[themeId]['primaryColor'],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => poetryItem(this.poetry),
              ),
            );
          },
        );
      },
    );
  }
}
