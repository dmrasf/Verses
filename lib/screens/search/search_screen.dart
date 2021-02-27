import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';
import 'package:Verses/screens/result/result_screen.dart';
import 'package:Verses/screens/search/components/search_and_poetry.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController myControllerAuthor = TextEditingController();
  final TextEditingController myControllerTitle = TextEditingController();
  final TextEditingController myControllerContent = TextEditingController();
  final FocusNode myFocusNodeAuthor = FocusNode();
  final FocusNode myFocusNodeTitle = FocusNode();
  final FocusNode myFocusNodeContent = FocusNode();
  String dynasty = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(),
          body: Builder(
            builder: (context) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SearchPoetry(
                      myControllerAuthor: myControllerAuthor,
                      myControllerTitle: myControllerTitle,
                      myControllerContent: myControllerContent,
                      myFocusNodeAuthor: myFocusNodeAuthor,
                      myFocusNodeTitle: myFocusNodeTitle,
                      myFocusNodeContent: myFocusNodeContent,
                      setDynasty: (value) {
                        this.dynasty = value;
                      },
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        VersesLocalizations.of(context).search,
                        style: TextStyle(
                          color: themeColor[themeId]['textColor'],
                        ),
                      ),
                      color: themeColor[themeId]['primaryColor'],
                      onPressed: () async {
                        myFocusNodeAuthor.unfocus();
                        myFocusNodeTitle.unfocus();
                        myFocusNodeContent.unfocus();
                        ConnectivityResult result = await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                VersesLocalizations.of(context).noNetWork,
                                style: TextStyle(color: themeColor[themeId]['textColor']),
                              ),
                              duration: Duration(milliseconds: 500),
                              backgroundColor: themeColor[themeId]['primaryColor'],
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                authorString: myControllerAuthor.text,
                                dynastyString: this.dynasty,
                                titleString: myControllerTitle.text,
                                contentString: myControllerContent.text,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
