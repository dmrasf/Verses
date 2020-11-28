import 'package:flutter/material.dart';

class SearchRemind extends StatelessWidget {
  final String reminds;

  SearchRemind({Key key, this.reminds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(this.reminds),
    );
  }
}

class DemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double center = size.width * 0.5;
    final double radius = size.width * 0.5;
    // 画笔
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    // 圆的中心点位置
    final Offset centerOffset = Offset(center, center);
    //画圆 canvas还有很多draw方法，可以画方 画圆弧 画线 画图片等等。。
    canvas.drawCircle(centerOffset, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class WaitASecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.teal,
        alignment: Alignment.center,
        child: CustomPaint(
          painter: DemoPainter(),
          size: Size(100, 100),
        ),
      ),
    );
  }
}
