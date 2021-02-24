import 'package:flutter/material.dart';
import 'package:Verses/utils.dart';
import 'package:Verses/contants.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class PoetryItemShowCard extends StatefulWidget {
  final Map<String, dynamic> poetry;
  final int themeId;
  PoetryItemShowCard({Key key, this.poetry, this.themeId}) : super(key: key);
  @override
  _PoetryItemShowCardState createState() => _PoetryItemShowCardState();
}

class _PoetryItemShowCardState extends State<PoetryItemShowCard> {
  int poetryShowType;
  Widget collectionNumbers = Container();
  Map<int, List<InlineSpan>> poeSave = Map<int, List<InlineSpan>>();
  List<InlineSpan> poeShow;
  String poetryStr;
  Timer timer;

  void getPoetryShowType() async {
    this.poetryShowType =
        await SharedPreferencesUtil.getData<int>('poetryShowType') ?? PoetryShowTypes['normal'];
    setState(() {
      poeSave[this.poetryShowType] = getContent(widget.poetry, poetryShowType: this.poetryShowType);
      this.poeShow = poeSave[this.poetryShowType];
    });
  }

  void updatePoetryShowType(String typeKey) async {
    if (this.poetryShowType == PoetryShowTypes['normal']) {
      this.poetryShowType = PoetryShowTypes[typeKey];
    } else if (this.poetryShowType == PoetryShowTypes['pinyin']) {
      this.poetryShowType = typeKey == 'fanti' ? PoetryShowTypes['all'] : PoetryShowTypes['normal'];
    } else if (this.poetryShowType == PoetryShowTypes['fanti']) {
      this.poetryShowType = typeKey == 'fanti' ? PoetryShowTypes['normal'] : PoetryShowTypes['all'];
    } else if (this.poetryShowType == PoetryShowTypes['all']) {
      this.poetryShowType =
          typeKey == 'fanti' ? PoetryShowTypes['pinyin'] : PoetryShowTypes['fanti'];
    }
    await SharedPreferencesUtil.setData<int>('poetryShowType', this.poetryShowType);
    setState(() {
      if (!poeSave.containsKey(this.poetryShowType)) {
        poeSave[this.poetryShowType] =
            getContent(widget.poetry, poetryShowType: this.poetryShowType);
      }
      this.poeShow = poeSave[this.poetryShowType];
    });
  }

  Future<String> updateCollectionNumbers() async {
    var httpClient = HttpClient();
    String url = urlPoetry + 'getlikes?poetrystr=' + this.poetryStr;
    bool result = false;
    var poetryCollectionNumbers;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        var poetryResult = await response.transform(utf8.decoder).join();
        poetryCollectionNumbers = json.decode(poetryResult);
        result = true;
      } else {
        result = false;
      }
    } catch (exception) {
      result = false;
    }

    if (result) {
      return poetryCollectionNumbers[0]['收藏数'].toString();
    }
    return '';
  }

  void getCollectionNumbers() async {
    await updateCollectionNumbers().then((String title) {
      this.collectionNumbers = Text('收藏数：' + title);
      setState(() {});
    });
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      updateCollectionNumbers().then((String title) {
        this.collectionNumbers = Text('收藏数：' + title);
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.poetryStr = poetryToString(widget.poetry);
    getPoetryShowType();
    getCollectionNumbers();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
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
                        children: poeShow,
                        style: TextStyle(
                          fontSize: 15,
                          color: themeColor[widget.themeId]['textColor'],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 5,
            endIndent: 5,
            height: 1,
          ),
          Container(
            height: size.height * 0.08,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                TextButton(
                  child: Text('拼'),
                  style: buttonForPoetryStyle(PoetryShowTypes['pinyin'], size),
                  onPressed: () {
                    updatePoetryShowType('pinyin');
                  },
                ),
                //TextButton(
                //child: Text('繁'),
                //style: buttonForPoetryStyle(PoetryShowTypes['fanti'], size),
                //onPressed: () {
                //updatePoetryShowType('fanti');
                //},
                //),
                Spacer(),
                collectionNumbers,
                Spacer(),
                FlatButton(
                  height: size.height * 0.05,
                  minWidth: size.height * 0.06,
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.copy,
                    size: size.height * 0.025,
                    color: themeColor[widget.themeId]['textColor'],
                  ),
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(
                          text: widget.poetry['题目'] +
                              '\n' +
                              widget.poetry['作者'] +
                              ' ' +
                              widget.poetry['朝代'] +
                              '\n' +
                              widget.poetry['内容']),
                    );
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.poetry['题目'] + ' ' + VersesLocalizations.of(context).copied,
                          style: TextStyle(color: themeColor[widget.themeId]['textColor']),
                        ),
                        duration: Duration(milliseconds: 500),
                        backgroundColor: themeColor[widget.themeId]['backgroundColor'],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: themeColor[widget.themeId]['primaryColor'],
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  ButtonStyle buttonForPoetryStyle(int type, Size size) {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size(size.height * 0.06, size.height * 0.05)),
      foregroundColor: MaterialStateProperty.all(
        themeColor[widget.themeId]['textColor'],
      ),
      overlayColor: (this.poetryShowType == PoetryShowTypes['all'] || this.poetryShowType == type)
          ? MaterialStateProperty.all(themeColor[widget.themeId]['primaryColor'])
          : MaterialStateProperty.all(themeColor[widget.themeId]['backgroundColor']),
      backgroundColor:
          (this.poetryShowType == PoetryShowTypes['all'] || this.poetryShowType == type)
              ? MaterialStateProperty.all(themeColor[widget.themeId]['backgroundColor'])
              : MaterialStateProperty.all(themeColor[widget.themeId]['primaryColor']),
    );
  }
}
