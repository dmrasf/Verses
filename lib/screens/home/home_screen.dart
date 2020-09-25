import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/components/title_and_search.dart';
import 'package:Verses/screens/home/components/poetry_card.dart';
import 'package:Verses/screens/home/components/today_and_more.dart';
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        iconSize: 8,
        onPressed: () {},
        icon: SvgPicture.asset(
          "assets/icons/heart.svg",
          height: 20,
          width: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String poetry =
        '{ "题目": "凉州词二首 其一", "朝代": "唐", "作者": "王翰", "内容": "葡萄美酒夜光杯，欲饮琵琶马上催。醉卧沙场君莫笑，古来征战几人回。" }';

    Map<String, dynamic> poe = json.decode(poetry);
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TitleAndSearch(),
                TodayPoetryAndMore(),
                PoetryCard(poetry: poe),
              ],
            ),
          ),
        ));
  }
}
