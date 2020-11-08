import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/result/result_screen.dart';
import 'package:Verses/screens/search/components/search_and_poetry.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController myControllerAuthor = TextEditingController();
  final TextEditingController myControllerDynasty = TextEditingController();
  final TextEditingController myControllerTitle = TextEditingController();
  final TextEditingController myControllerContent = TextEditingController();
  final FocusNode myFocusNodeAuthor = FocusNode();
  final FocusNode myFocusNodeDynasty = FocusNode();
  final FocusNode myFocusNodeTitle = FocusNode();
  final FocusNode myFocusNodeContent = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SearchPoetry(
              myControllerAuthor: myControllerAuthor,
              myControllerDynasty: myControllerDynasty,
              myControllerTitle: myControllerTitle,
              myControllerContent: myControllerContent,
              myFocusNodeAuthor: myFocusNodeAuthor,
              myFocusNodeDynasty: myFocusNodeDynasty,
              myFocusNodeTitle: myFocusNodeTitle,
              myFocusNodeContent: myFocusNodeContent,
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
                myFocusNodeAuthor.unfocus();
                myFocusNodeDynasty.unfocus();
                myFocusNodeTitle.unfocus();
                myFocusNodeContent.unfocus();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(
                            authorString: myControllerAuthor.text,
                            dynastyString: myControllerDynasty.text,
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
