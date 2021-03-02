import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/comments/components/comment_list_item.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CommentsType { top, latest }

class CommentsListView extends StatefulWidget {
  final List<Map<String, dynamic>> comments;
  final String phoneID;
  final int themeId;
  final String poetryStr;
  final Function updateComments;

  CommentsListView({
    Key key,
    this.comments,
    this.phoneID,
    this.poetryStr,
    this.themeId,
    this.updateComments,
  }) : super(key: key);

  @override
  _CommentsListViewState createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  CommentsType commentsType = CommentsType.latest;

  void changeComment() {
    widget.updateComments();
  }

  @override
  void initState() {
    widget.comments.sort((a, b) => b['评论时间'].compareTo(a['评论时间']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            height: size.height * 0.04,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Text(
                  commentsType == CommentsType.top
                      ? VersesLocalizations.of(context).commentsTop
                      : VersesLocalizations.of(context).commentsNew,
                  style: TextStyle(
                    color: themeColor[widget.themeId]['textColor'],
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  child: SvgPicture.asset(
                    "assets/icons/pair.svg",
                    height: 10,
                    width: 10,
                    color: themeColor[widget.themeId]['textColor'],
                  ),
                  onTap: () {
                    this.commentsType = this.commentsType == CommentsType.top
                        ? CommentsType.latest
                        : CommentsType.top;
                    if (this.commentsType == CommentsType.top) {
                      widget.comments.sort((a, b) => b['点赞数'].compareTo(a['点赞数']));
                    } else {
                      widget.comments.sort((a, b) => b['评论时间'].compareTo(a['评论时间']));
                    }
                    setState(() {});
                  },
                ),
                Container(width: size.width * 0.02),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: RefreshIndicator(
                onRefresh: () async {
                  widget.updateComments();
                  await Future.delayed(Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: widget.comments.length,
                  itemBuilder: (context, index) {
                    return CommentListItem(
                      comment: widget.comments[index],
                      themeId: widget.themeId,
                      phoneID: widget.phoneID,
                      poetryStr: widget.poetryStr,
                      updateComments: widget.updateComments,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
