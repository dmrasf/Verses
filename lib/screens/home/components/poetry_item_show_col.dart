import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';
import 'package:provider/provider.dart';
import 'package:Verses/contants.dart';

class PoetryItemShowForCol extends StatelessWidget {
  final Map<String, dynamic> poetry;

  PoetryItemShowForCol({Key key, this.poetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Column(
                  children: [
                    Container(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: getContent(this.poetry),
                          style: TextStyle(
                            fontFamily: 'LongCang',
                            fontSize: 25,
                            color: themeColor[themeId]['textColor'],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: themeColor[themeId]['primaryColor'],
        );
      },
    );
  }
}
