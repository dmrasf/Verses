import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: IconButton(
          iconSize: 8,
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/heart.svg"),
        ),
      ),
      body: Container(),
    );
  }
}
