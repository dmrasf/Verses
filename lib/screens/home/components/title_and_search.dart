import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:Verses/screens/search/search_screen.dart';

class TitleAndSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                color: themeColor[themeId]["primaryColor"],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(size.width * 0.1),
                  bottomRight: Radius.circular(size.width * 0.1),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: size.width * 0.28,
              child: Center(
                child: Text(
                  VersesLocalizations.of(context).heading,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: size.width * 0.1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding * 3),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
                height: size.width * 0.1,
                decoration: BoxDecoration(
                  color: themeColor[themeId]['backgroundColor'],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SearchScreen()));
                  },
                  child: Row(children: [
                    Text(
                      VersesLocalizations.of(context).search,
                      style: TextStyle(
                        fontSize: 15,
                        color: themeColor[themeId]['textColor'],
                      ),
                    ),
                    Spacer(),
                    ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        width: 10,
                        height: 10,
                        color: themeColor[themeId]['textColor'],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
