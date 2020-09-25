import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/components/title_and_search.dart';
import 'package:Verses/screens/home/components/today_and_more.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TitleAndSearch(),
                TodayPoetryAndMore(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding * 0.2,
                  ),
                  width: size.width * 0.9,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "曹雪芹\n清",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "好了歌注",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/icons/heart.svg",
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(text: "陋室空堂，当年笏满床；\n"),
                              TextSpan(text: "衰草枯杨，曾为歌舞场。\n"),
                              TextSpan(text: "蛛丝儿结满雕梁，绿纱今又糊在蓬窗上。\n"),
                              TextSpan(text: "说什么脂正浓，粉正香，如何两鬓又成霜？\n"),
                              TextSpan(text: "昨日黄土陇头送白骨，今宵红灯帐底卧鸳鸯。\n"),
                              TextSpan(text: "金满箱，银满箱，展眼乞丐人皆谤。\n"),
                              TextSpan(text: "正叹他人命不长，那知自己归来丧！\n"),
                              TextSpan(text: "训有方，保不定日后作强梁。\n"),
                              TextSpan(text: "择膏粱，谁承望流落在烟花巷！\n"),
                              TextSpan(text: "因嫌纱帽小，致使锁枷杠。\n"),
                              TextSpan(text: "昨怜破袄寒，今嫌紫蟒长：\n"),
                              TextSpan(text: "乱烘烘你方唱罢我登场，反认他乡是故乡。\n"),
                              TextSpan(text: "甚荒唐，到头来都是为他人作嫁衣裳！\n"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: kPirmaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
