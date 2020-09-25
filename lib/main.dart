import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verses',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPirmaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
