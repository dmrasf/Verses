import 'package:flutter/material.dart';
import 'package:Verses/screens/home/components/title_and_search.dart';
import 'package:Verses/screens/home/components/poetry_card.dart';
import 'package:Verses/screens/home/components/home_communication.dart';
import 'package:Verses/screens/home/components/today_and_more.dart';
import 'package:Verses/screens/home/components/icon_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
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

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        iconSize: 8,
        // 打开收藏
        onPressed: () {},
        icon: SvgPicture.asset(
          "assets/icons/heart.svg",
          height: 20,
          width: 20,
        ),
      ),
      actions: [
        //IconButton(
        //iconSize: 8,
        //onPressed: _downloadPoetry,
        //icon: SvgPicture.asset(
        //"assets/icons/download.svg",
        //height: 20,
        //width: 20,
        //color: Colors.black,
        //),
        //),
        IconChangeTheme(),
      ],
    );
  }
}
