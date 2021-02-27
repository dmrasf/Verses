import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Verses/screens/collection/components/poetry_item_show.dart';

class PoetryCard extends StatefulWidget {
  PoetryCard({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PoetryCardState();
  }
}

class PoetryCardState extends State<PoetryCard> {
  Map<String, dynamic> _poetry = Map<String, dynamic>();
  bool _isLike = false;

  @override
  void initState() {
    super.initState();
    getDayPoetry(true);
  }

  void getDayPoetry(bool isDay) async {
    Map<String, dynamic> tmp = await getPoetry(isDay);
    if (tmp.isNotEmpty) {
      this._poetry = tmp;
      this._isLike = (await isPoetryCollection(this._poetry))[0];
      setState(() {});
    }
  }

  void _pressCol() async {
    // 读取保存的文件
    this._isLike = await collectionToggle(this._poetry);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // 如果没有诗词不显示卡片
    if (this._poetry.isEmpty) {
      return Container();
    }
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PoetryItemShowForCol(
                  poetry: this._poetry,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: kDefaultPadding * 0.5),
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding * 0.6,
            ),
            width: size.width * 0.9,
            child: Column(
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "${_poetry['作者']}\n${_poetry['朝代']}",
                        style: TextStyle(
                          fontSize: 12,
                          color: themeColor[themeId]["textColor"],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: size.width * 0.5,
                      child: Text(
                        "${_poetry['题目']}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: _pressCol,
                      icon: SvgPicture.asset("assets/icons/heart.svg",
                          height: 20,
                          width: 20,
                          color: _isLike ? Colors.red : themeColor[themeId]['backgroundColor']),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: getContent(this._poetry),
                      style: TextStyle(color: themeColor[themeId]['textColor']),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: themeColor[themeId]["primaryColor"],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
