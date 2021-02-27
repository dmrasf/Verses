import 'package:flutter/material.dart';
import 'package:Verses/screens/home/components/title_and_search.dart';
import 'package:Verses/screens/home/components/poetry_card.dart';
import 'package:Verses/screens/home/components/home_communication.dart';
import 'package:Verses/screens/home/components/today_and_more.dart';
import 'package:Verses/screens/home/components/icon_theme.dart';
import 'package:Verses/screens/home/components/home_collection_view.dart';
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
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.home),
        onPressed: () {},
        color: Colors.white,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        iconSize: 8,
        onPressed: () async {
          List<Map<String, dynamic>> poetries = await getCollection();
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (
                BuildContext context,
                Animation animation,
                Animation secondaryAnimation,
              ) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-1.0, 0.0),
                    end: Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  )),
                  child: CollectionListView(poetries: poetries),
                );
              },
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
