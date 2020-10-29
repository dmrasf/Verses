import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/result/result_screen.dart';
import 'package:Verses/screens/search/components/search_and_poetry.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController myControllerAuthor = TextEditingController();
  final TextEditingController myControllerDynasity = TextEditingController();
  final TextEditingController myControllerTitle = TextEditingController();
  final TextEditingController myControllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SearchPoetry(
              myControllerAuthor: myControllerAuthor,
              myControllerDynasity: myControllerDynasity,
              myControllerTitle: myControllerTitle,
              myControllerContent: myControllerContent,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: kPirmaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(
                            authorString: myControllerAuthor.text,
                            dynasityString: myControllerDynasity.text,
                            titleString: myControllerTitle.text,
                            contentString: myControllerContent.text)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
