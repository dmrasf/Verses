import 'package:flutter/material.dart';
import 'package:verses/contants.dart';
import 'package:verses/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verses/screens/comments/components/comment_list_view.dart';

class CommentScreen extends StatefulWidget {
  final String phoneID;
  final int themeId;
  final String poetryStr;

  CommentScreen({Key key, this.phoneID, this.themeId, this.poetryStr}) : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<Map<String, dynamic>> comments = List<Map<String, dynamic>>();
  Widget commentsView = Container();
  TextEditingController controller;
  FocusNode focusNode;

  void updateComments() async {
    comments = await getComments(widget.poetryStr, widget.phoneID);
    if (comments.length == 0) {
      this.commentsView = Container(
        alignment: Alignment.center,
        child: Text(
          VersesLocalizations.of(context).noComments,
          style: TextStyle(
            color: themeColor[widget.themeId]['textColor'],
          ),
        ),
      );
    } else {
      this.commentsView = CommentsListView(
        key: UniqueKey(),
        comments: comments,
        phoneID: widget.phoneID,
        poetryStr: widget.poetryStr,
        themeId: widget.themeId,
        updateComments: updateComments,
      );
    }
    //addComment(widget.poetryStr, widget.phoneID, 'comment test2');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    updateComments();
    controller = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 7),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: size.height * 0.03,
            margin: EdgeInsets.only(top: 3),
            child: Text(
              VersesLocalizations.of(context).commentsNum + this.comments.length.toString(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: themeColor[widget.themeId]['textColor'],
              ),
            ),
          ),
          Expanded(
            child: commentsView,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: this.controller,
              focusNode: this.focusNode,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () async {
                    focusNode.unfocus();
                    if (this.controller.text != '') {
                      await addComment(
                        widget.poetryStr,
                        widget.phoneID,
                        this.controller.text,
                      );
                      updateComments();
                    }
                    this.controller.clear();
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/publish.svg",
                    height: size.height * 0.03,
                    width: size.height * 0.03,
                    color: themeColor[widget.themeId]['textColor'],
                  ),
                ),
                hintText: VersesLocalizations.of(context).inputComment,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: themeColor[widget.themeId]['textColor'],
                ),
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
        ],
      ),
    );
  }
}
