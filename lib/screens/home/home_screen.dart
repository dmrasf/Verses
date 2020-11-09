import 'package:flutter/material.dart';
import 'package:Verses/screens/home/components/title_and_search.dart';
import 'package:Verses/screens/home/components/poetry_card.dart';
import 'package:Verses/screens/home/components/home_communication.dart';
import 'package:Verses/screens/home/components/today_and_more.dart';
import 'package:Verses/screens/home/components/icon_theme.dart';
import 'package:Verses/components/poetry_list_and_item.dart';
import 'package:Verses/screens/home/components/poetry_item_show_col.dart';
import 'package:Verses/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TitleAndSearch(),
                TodayPoetryAndMore(),
                PoetryCard(key: keyValue),
              ],
            ),
          ),
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        iconSize: 8,
        onPressed: () async {
          // 打开收藏的诗词
          List<Map<String, dynamic>> poetries = await getCollection();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: PoetryListView(
                  poetries: poetries,
                  poetryItem: (poetry) => PoetryItemShowForCol(poetry: poetry),
                ),
              ),
            ),
          );
        },
        icon: SvgPicture.asset(
          "assets/icons/heart.svg",
          height: 20,
          width: 20,
        ),
      ),
      actions: [
        IconChangeTheme(),
      ],
    );
  }
}

class CollentionListView extends StatelessWidget {
  final List<Map<String, dynamic>> poetries;

  CollentionListView({Key key, this.poetries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.poetries.length,
      itemBuilder: (context, index) {
        return PoetryListItem(poetry: this.poetries[index]);
      },
    );
  }
}
