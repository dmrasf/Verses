import 'package:Verses/screens/home/components/poetry_card.dart';
import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:provider/provider.dart';

class TodayPoetryAndMore extends StatelessWidget {
  void _press() {
    (keyForCard.currentState as PoetryCardState).getDayPoetry(false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: kDefaultPadding / 4),
                child: Text(
                  VersesLocalizations.of(context).todayPoetry,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text(
                  VersesLocalizations.of(context).change,
                  style: TextStyle(
                    color: themeColor[themeId]["textColor"],
                  ),
                ),
                color: themeColor[themeId]["primaryColor"],
                onPressed: _press,
              ),
            ],
          ),
        );
      },
    );
  }
}
