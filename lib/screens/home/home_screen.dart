import 'package:flutter/material.dart';
import 'package:verses/screens/home/components/title_and_search.dart';
import 'package:verses/screens/home/components/poetry_card.dart';
import 'package:verses/screens/home/components/today_and_more.dart';
import 'package:verses/screens/home/components/icon_theme.dart';
import 'package:verses/screens/collection/collection_screen.dart';
import 'package:verses/utils.dart';
import 'package:verses/contants.dart';
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
              PoetryCard(key: keyForCard),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        iconSize: 8,
        onPressed: () async {
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
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                  child: CollectionListView(),
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
