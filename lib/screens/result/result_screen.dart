import 'package:flutter/material.dart';
import 'package:verses/components/poetry_list_and_item.dart';
import 'package:verses/screens/result/components/poetry_item_show.dart';
import 'package:verses/screens/result/components/search_remind.dart';
import 'package:verses/utils.dart';

class ResultScreen extends StatefulWidget {
  final String authorString;
  final String dynastyString;
  final String titleString;
  final String contentString;

  const ResultScreen({
    Key key,
    this.authorString,
    this.dynastyString,
    this.titleString,
    this.contentString,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ResultScreenState(
        authorString: this.authorString,
        dynastyString: this.dynastyString,
        titleString: this.titleString,
        contentString: this.contentString);
  }
}

class ResultScreenState extends State<ResultScreen> {
  final String authorString;
  final String dynastyString;
  final String titleString;
  final String contentString;
  // 存放搜索到的诗词
  List<Map<String, dynamic>> poetries = [];
  Widget body;
  ScrollController scrollController = ScrollController();
  int scrollListenerLock = 0;

  ResultScreenState({
    this.authorString,
    this.dynastyString,
    this.titleString,
    this.contentString,
  });

  @override
  void initState() {
    super.initState();
    updatePoetry();
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          scrollListenerLock == 0) {
        scrollListenerLock = 1;
        await updatePoetries();
        scrollListenerLock = 0;
      }
    });
  }

  Future<void> updatePoetries() async {
    List<Map<String, dynamic>> searchPoetry;
    int block = (this.poetries.length - 1) ~/ 50 + 1;
    searchPoetry = await getPoetries(
      this.authorString,
      this.titleString,
      this.dynastyString,
      this.contentString,
      block.toString(),
    );
    if (!searchPoetry[0].containsKey('error') &&
        searchPoetry.length > 0 &&
        !searchPoetry[0].containsKey('warning')) {
      for (var i = 0, len = searchPoetry.length; i < len; ++i) {
        this.poetries.add(searchPoetry[i]);
      }
    }
    this.body = getListPoetry();
    setState(() {});
  }

  void updatePoetry() async {
    List<Map<String, dynamic>> searchPoetry;

    setState(() {
      this.body = SearchRemind(reminds: "稍等，正在查询中！");
    });
    searchPoetry = await getPoetries(
      this.authorString,
      this.titleString,
      this.dynastyString,
      this.contentString,
      '0',
    );
    if (searchPoetry[0].containsKey('error')) {
      this.body = SearchRemind(reminds: searchPoetry[0]['error']);
    } else if (searchPoetry.length == 0 || searchPoetry[0].containsKey('warning')) {
      this.body = SearchRemind(reminds: searchPoetry[0]['warning']);
    } else {
      for (var i = 0, len = searchPoetry.length; i < len; ++i) {
        this.poetries.add(searchPoetry[i]);
      }
      this.body = getListPoetry();
    }
    setState(() {});
  }

  Widget getListPoetry() {
    return Scrollbar(
      child: ListView.builder(
        controller: this.scrollController,
        itemCount: this.poetries.length,
        itemBuilder: (context, index) {
          return PoetryListItem(
            poetry: this.poetries[index],
            poetryItem: (poetry) => PoetryItemShow(poetry: poetry),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '找到 ' + this.poetries.length.toString() + ' 首',
          style: TextStyle(fontSize: 12),
        ),
        centerTitle: true,
      ),
      body: this.body,
    );
  }
}
