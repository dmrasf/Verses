import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/components/poetry_item_show_card.dart';

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
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: PoetryItemShowCard(poetry: widget.poetry, themeId: themeId),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  width: size.width,
                  height: size.height * 0.08,
                  alignment: Alignment.center,
                  child: isLike ? Text('Unlike') : Text('Like'),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: isLike ? Colors.red : themeColor[themeId]['primaryColor'],
                  ),
                ),
                onTap: _press,
              ),
            ],
          ),
          backgroundColor: themeColor[themeId]['backgroundColor'],
        );
      },
    );
  }
}
