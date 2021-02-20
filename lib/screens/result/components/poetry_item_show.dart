import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:Verses/contants.dart';

class PoetryItemShow extends StatefulWidget {
  final Map<String, dynamic> poetry;

  PoetryItemShow({Key key, this.poetry}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PoetryItemShowState();
  }
}

class _PoetryItemShowState extends State<PoetryItemShow> {
  bool isLike = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    this.isLike = (await isPoetryCollection(widget.poetry))[0];
    setState(() {});
  }

  void _press() async {
    this.isLike = await collectionToggle(widget.poetry);
    setState(() {});
  }

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
                          children: getContent(widget.poetry),
                          style: TextStyle(
                            fontSize: 15,
                            color: themeColor[themeId]['textColor'],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _press,
                      icon: SvgPicture.asset(
                        "assets/icons/heart.svg",
                        height: 40,
                        width: 40,
                        color: isLike ? Colors.red : themeColor[themeId]['backgroundColor'],
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
