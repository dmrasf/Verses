import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';
import 'package:provider/provider.dart';
import 'package:Verses/contants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PoetryItemShowForCol extends StatefulWidget {
  final Map<String, dynamic> poetry;

  PoetryItemShowForCol({Key key, this.poetry}) : super(key: key);
  @override
  _PoetryItemShowForColState createState() => _PoetryItemShowForColState(poetry: this.poetry);
}

class _PoetryItemShowForColState extends State<PoetryItemShowForCol> {
  final Map<String, dynamic> poetry;

  _PoetryItemShowForColState({this.poetry});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              this.poetry['题目'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.center,
                          child: Container(
                            width: size.width,
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: getContent(this.poetry),
                                    style: TextStyle(
                                      fontFamily: 'LongCang',
                                      fontSize: 20,
                                      color: themeColor[themeId]['textColor'],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.06,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [],
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: themeColor[themeId]['primaryColor'],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.1,
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.music_note),
                        color: themeColor[themeId]['textColor'],
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.comment),
                        color: themeColor[themeId]['textColor'],
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.feedback),
                        color: themeColor[themeId]['textColor'],
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: Icon(Icons.share),
                        color: themeColor[themeId]['textColor'],
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: themeColor[themeId]['backgroundColor'],
        );
      },
    );
  }
}
