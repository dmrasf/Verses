import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Verses/screens/result/result_screen.dart';
import 'dart:convert';

class CollectionQrView extends StatefulWidget {
  @override
  _CollectionQrViewState createState() => _CollectionQrViewState();
}

class _CollectionQrViewState extends State<CollectionQrView> {
  StateSetter stateSetter;
  IconData lightIcon = Icons.flash_on;
  ScanController controller = ScanController();
  Widget body;

  void getResult(String result) {
    controller.pause();
    print(result);
    Map<String, dynamic> poetry = jsonDecode(result);
    if (poetry.containsKey('题目') &&
        poetry.containsKey('内容') &&
        poetry.containsKey('作者') &&
        poetry.containsKey('朝代')) {
      setState(() {
        this.body = ResultScreen(
          authorString: poetry['作者'],
          titleString: poetry['题目'],
          dynastyString: poetry['朝代'],
          contentString: poetry['内容'],
        );
      });
    }
  }

  @override
  void initState() {
    this.body = Scaffold(
      appBar: AppBar(
        title: Text(
          '查找诗词',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ScanView(
            controller: controller,
            scanAreaScale: .7,
            scanLineColor: Colors.black,
            onCapture: (data) {
              getResult(data);
            },
          ),
          Positioned(
            left: 100,
            bottom: 60,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                stateSetter = setState;
                return MaterialButton(
                    child: Icon(
                      lightIcon,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      controller.toggleTorchMode();
                      if (lightIcon == Icons.flash_on) {
                        lightIcon = Icons.flash_off;
                      } else {
                        lightIcon = Icons.flash_on;
                      }
                      stateSetter(() {});
                    });
              },
            ),
          ),
          Positioned(
            right: 100,
            bottom: 60,
            child: MaterialButton(
                child: Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                onPressed: () async {
                  final _picker = ImagePicker();
                  PickedFile image = await _picker.getImage(source: ImageSource.gallery);
                  if (image != null) {
                    String result = await Scan.parse(image.path);
                    getResult(result);
                  }
                }),
          ),
        ],
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this.body;
  }
}
