import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: getContent(widget.poetry),
                  ),
                ),
              ),
              IconButton(
                onPressed: _press,
                icon: SvgPicture.asset(
                  "assets/icons/heart.svg",
                  height: 40,
                  width: 40,
                  color: isLike ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
