import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';

class TodayPoetryAndMore extends StatelessWidget {
  void press() {}

  @override
  Widget build(BuildContext context) {
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
              "Today Poetry",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Change",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: kPirmaryColor,
            onPressed: press,
          ),
        ],
      ),
    );
  }
}
