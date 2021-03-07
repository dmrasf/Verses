import 'package:flutter/material.dart';
import 'package:verses/contants.dart';
import 'package:verses/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentListItem extends StatefulWidget {
  final String phoneID;
  final int themeId;
  final String poetryStr;
  final Map<String, dynamic> comment;
  final Function updateComments;

  CommentListItem({
    Key key,
    this.comment,
    this.phoneID,
    this.poetryStr,
    this.themeId,
    this.updateComments,
  }) : super(key: key);

  @override
  _CommentListItemState createState() => _CommentListItemState();
}

class _CommentListItemState extends State<CommentListItem> {
  Widget toolButton = Container();
  BuildContext cnt;
  Size size;
  bool tmpLikes;

  Future<String> getNewComment(String oldComment) async {
    var controller = TextEditingController();
    String newComment = '';
    controller.text = oldComment;
    await showDialog(
      context: cnt,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(VersesLocalizations.of(cnt).changeComment),
          titleTextStyle: TextStyle(
            color: themeColor[widget.themeId]['textColor'],
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: themeColor[widget.themeId]['primaryColor'],
          contentPadding: EdgeInsets.only(bottom: 2, left: 24, right: 24, top: 20),
          content: Container(
            height: this.size.height * 0.2,
            width: this.size.width * 0.7,
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.newline,
                    maxLines: 3,
                    minLines: 1,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        borderSide: BorderSide(color: themeColor[widget.themeId]['textColor']),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        borderSide: BorderSide(color: themeColor[widget.themeId]['textColor']),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text(
                          VersesLocalizations.of(cnt).cancel,
                          style: TextStyle(color: themeColor[widget.themeId]['textColor']),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          VersesLocalizations.of(cnt).confirm,
                          style: TextStyle(color: themeColor[widget.themeId]['textColor']),
                        ),
                        onPressed: () {
                          newComment = controller.text;
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );

    return newComment;
  }

  Widget getToolButton(String fuc) {
    return GestureDetector(
      child: Container(
        child: Text(
          fuc == 'delete'
              ? VersesLocalizations.of(cnt).deleteComment
              : VersesLocalizations.of(cnt).changeComment,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: themeColor[widget.themeId]['textColor'],
          ),
        ),
      ),
      onTap: () async {
        if (fuc == 'delete') {
          await removeComment(
            widget.poetryStr,
            widget.phoneID,
            widget.comment['评论时间'],
            widget.comment['评论'],
          );
        } else {
          String newComment = await getNewComment(widget.comment['评论']);
          if (newComment != widget.comment['评论'] && newComment != '') {
            await changeComment(
              widget.poetryStr,
              widget.phoneID,
              widget.comment['评论时间'],
              newComment,
            );
          }
        }
        widget.updateComments();
      },
    );
  }

  void getToolButtons() async {
    if (widget.phoneID == widget.comment['识别码']) {
      this.toolButton = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          getToolButton('delete'),
          Container(width: size.width * 0.03),
          getToolButton('change'),
        ],
      );
    } else {
      this.toolButton = Container();
    }
    setState(() {});
  }

  void changeLike() async {
    if (this.tmpLikes == widget.comment['isLike']) return;
    if (this.tmpLikes) {
      changeCommentLikeStatus(
        widget.poetryStr,
        widget.comment['识别码'],
        widget.phoneID,
        widget.comment['评论时间'],
        'add',
      );
    } else {
      changeCommentLikeStatus(
        widget.poetryStr,
        widget.comment['识别码'],
        widget.phoneID,
        widget.comment['评论时间'],
        'remove',
      );
    }
  }

  String getLikesNum() {
    if (this.tmpLikes == widget.comment['isLike']) return widget.comment['点赞数'].toString();
    if (this.tmpLikes) {
      return (widget.comment['点赞数'] + 1).toString();
    } else {
      return widget.comment['点赞数'] - 1 < 0 ? 0.toString() : (widget.comment['点赞数'] - 1).toString();
    }
  }

  @override
  void initState() {
    this.tmpLikes = widget.comment['isLike'] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.cnt = context;
    getToolButtons();
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 10),
      padding: EdgeInsets.only(left: 8, right: 8, top: 0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.comment['评论时间'].toString(),
                style: TextStyle(
                  fontSize: 8,
                  color: themeColor[widget.themeId]['textColor'],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  this.tmpLikes = !this.tmpLikes;
                  changeLike();
                  setState(() {});
                },
                child: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/like.svg",
                        height: 13,
                        width: 13,
                        color: this.tmpLikes ? Colors.red : themeColor[widget.themeId]['textColor'],
                      ),
                      Text(
                        " " + getLikesNum(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.comment['评论'],
              style: TextStyle(
                color: themeColor[widget.themeId]['textColor'],
                fontSize: 15,
              ),
            ),
          ),
          Container(
            child: this.toolButton,
          ),
          Divider(
            thickness: 0.3,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
