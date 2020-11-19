import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/components/home_communication.dart';

class TodayPoetryAndMore extends StatelessWidget {
  void _press() {
    // 使用global key 进行组件间通信
    keyValue.currentState.getPoetry(false);
  }

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
                color: Colors.white,
              ),
            ),
            color: kPirmaryColor,
            onPressed: _press,
          ),
        ],
      ),
    );
  }
}
