import 'package:Verses/contants.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class CollectionShare extends StatelessWidget {
  final String poeStr;
  final int themeId;

  CollectionShare(this.poeStr, this.themeId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请扫描二维码',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: keyForQrCode,
                child: Container(
                  color: themeColor[this.themeId]['backgroundColor'],
                  child: QrImage(
                    foregroundColor: themeColor[this.themeId]['textColor'],
                    data: this.poeStr,
                    size: 300,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              TextButton(
                child: Text('保存'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(themeColor[themeId]['textColor']),
                  backgroundColor: MaterialStateProperty.all(themeColor[themeId]['primaryColor']),
                  shadowColor: MaterialStateProperty.all(themeColor[themeId]['textColor']),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  elevation: MaterialStateProperty.resolveWith((state) {
                    if (state.contains(MaterialState.pressed)) return 0;
                    return 4;
                  }),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(150, 60)),
                ),
                onPressed: () async {
                  await saveQrCode(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future saveQrCode(BuildContext cnt) async {
    await [Permission.storage].request();
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      openAppSettings();
    } else {
      bool isSuccess = false;
      try {
        RenderRepaintBoundary boundary = keyForQrCode.currentContext.findRenderObject();
        ui.Image image = await boundary.toImage();
        ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        isSuccess = result['isSuccess'];
      } catch (e) {
        print(e);
      }
      Scaffold.of(cnt).showSnackBar(
        SnackBar(
          content: Text(
            isSuccess ? '保存成功' : '保存失败',
            style: TextStyle(color: themeColor[this.themeId]['textColor']),
          ),
          duration: Duration(milliseconds: 500),
          backgroundColor: themeColor[this.themeId]['primaryColor'],
        ),
      );
    }
  }
}
