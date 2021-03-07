import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:verses/contants.dart';
import 'package:verses/utils.dart';
import 'package:verses/screens/comments/comment_screen.dart';
import 'package:verses/screens/collection/components/share_view.dart';

class CollectionPoetryShowButtons extends StatelessWidget {
  final int themeId;
  final Map<String, dynamic> poetry;
  BuildContext cnt;
  Size size;

  CollectionPoetryShowButtons({Key key, this.poetry, this.themeId}) : super(key: key);

  Widget getToolButton(IconData icon, Function _press) {
    return FlatButton(
      height: size.height * 0.1,
      padding: EdgeInsets.all(0),
      child: Icon(icon, color: themeColor[this.themeId]['textColor']),
      color: themeColor[themeId]['primaryColor'],
      onPressed: _press,
    );
  }

  @override
  Widget build(BuildContext context) {
    this.cnt = context;
    this.size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: size.width,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 8),
      decoration: BoxDecoration(
        color: themeColor[this.themeId]['primaryColor'],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          //Expanded(
          //child: getToolButton(Icons.music_note, this.funcPlay),
          //),
          Expanded(
            child: getToolButton(Icons.comment, this.funcComment),
          ),
          Expanded(
            child: getToolButton(Icons.feedback, this.funcFeedback),
          ),
          Expanded(
            child: getToolButton(Icons.share, this.funcShare),
          ),
        ],
      ),
    );
  }

  void funcComment() async {
    String phoneID = await getUniqueId();
    showBottomSheet(
      context: cnt,
      backgroundColor: themeColor[this.themeId]['commentBackgroundColor'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: this.size.height * 0.7,
          width: this.size.width,
          child: CommentScreen(
            phoneID: phoneID,
            themeId: this.themeId,
            poetryStr: poetryToString(this.poetry),
          ),
        );
      },
    );
  }

  void funcFeedback() {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();
    focusNode.requestFocus();
    showDialog(
      context: cnt,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return Dialog(
          backgroundColor: themeColor[this.themeId]['primaryColor'],
          child: Container(
            height: size.height * 0.4,
            width: size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  color: Colors.red,
                  child: Text(
                    '反馈错误',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          '请输入详细信息',
                          style: TextStyle(
                            color: themeColor[this.themeId]['backTextColor'],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          style: TextStyle(
                            color: themeColor[this.themeId]['textColor'],
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 7,
                          decoration: InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        child: Text(
                          '取消',
                          style: TextStyle(
                            color: themeColor[this.themeId]['textColor'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            themeColor[this.themeId]['overlayColor'],
                          ),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          '提交',
                          style: TextStyle(
                            color: themeColor[this.themeId]['textColor'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          print(controller.text);
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                            themeColor[this.themeId]['overlayColor'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void funcShare() {
    String poeStr = jsonEncode(this.poetry);
    Navigator.push(
      cnt,
      MaterialPageRoute(
        builder: (cnt) => CollectionShare(poeStr, this.themeId),
      ),
    );
  }
}
